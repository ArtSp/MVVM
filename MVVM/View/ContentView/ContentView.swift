
import SwiftUI
import MPSwiftUI

// MARK: - IO

extension ContentView: ViewModelView {
    
    struct ViewState {
        var onboardingCompleted = false
        var items: [Item]?
        var isLoading = Set<LoadingContent>()
    }
    
    enum ViewInput {
        case loadItems
        case resetOnboarding
    }
    
    enum LoadingContent {
        case items
    }
    
}

// MARK: - ContentView

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    @Injected(\.view.factory) var factory
    @Preference(\.bundleLanguage) var bundleLanguage
    @State private var onboardingVM: OnboardingView.ViewModel?
    @State private var onboardingVM2: OnboardingView.ViewModel?
    
    private func createViewModel(
        for destination: Destination
    ) {
        DispatchQueue.main.async {
            switch destination {
            case .onboarding:
                onboardingVM = factory.newOnboardingVM()
                
                
            case .onboardingPreview:
                onboardingVM2 = factory.newOnboardingVM()
            }
        }
    }
    
    func showOnboarding(
        _ show: Bool
    ) {
        if show {
            createViewModel(for: .onboarding)
        } else {
            onboardingVM = nil
        }
    }
    
    var body: some View {
        MVVMNavigationView {
            VStack {
                
                Picker("home.picker.language", selection: $bundleLanguage.binding) {
                    ForEach(Language.allCases) { language in
                        Text(language.name.capitalized)
                            .tag(language)
                    }
                }
                .pickerStyle(.segmented)
                .padding2x(.bottom)
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                
                Unwrap(viewModel.items) { items in
                    ItemList(items: items)
                } fallbackContent: {
                    ItemList(items: Item.placeholders(count: 3))
                        .isPlaceholder(true)
                        .isHidden(!viewModel.isLoading.contains(.items))
                }
                .shimmed(viewModel.isLoading.contains(.items))
                
                Spacer()
                
                Button("home.button.reset") {
                    trigger(.resetOnboarding)
                }
                .buttonStyle(.mvvmButton())
                
                Button("home.button.about") {
                    createViewModel(for: .onboardingPreview)
                }
                .buttonStyle(.mvvmButton(palette: .mvvmBackground))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .scrollViewIfNeeded(.vertical)
            .navigationTitle("home.hello")
            .navigation(item: $onboardingVM2) { vm in
                OnboardingView(viewModel: vm)
            }
            .fullScreenCover(item: $onboardingVM) { vm in
                MVVMNavigationView {
                    OnboardingView(viewModel: vm)
                }
                .flow(.onboarding)
            }
            .onAppear {
                trigger(.loadItems)
                showOnboarding(!viewModel.onboardingCompleted)
            }
            .onChange(of: viewModel.onboardingCompleted) { onboardingCompleted in
                showOnboarding(!onboardingCompleted)
            }

        }
    }
}

extension ContentView {
    struct ItemList: View {
        @Environment(\.isPlaceholder) private var isPlaceholder
        @Environment(\.locale) var locale
        let items: [Item]
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("home.items".localized(for: locale) + ":")
                    .redacted(false)
                    .textStyle(.headline)
                
                VStack(alignment: .leading) {
                    ForEach(items) { item in
                        HStack {
                            Image(systemName: "smallcircle.filled.circle")
                            Text(item.name)
                                .textStyle(.body)
                                .padding(.vertical)
                        }
                        
                        Divider()
                            .isHidden(item.id == items.last?.id)
                    }
                    
                }
            }
            .padding(.vertical)
            .redacted(isPlaceholder)
        }
    }
}

// MARK: - Private data models

private extension ContentView {
    enum Destination {
        case onboarding
        case onboardingPreview
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    @Injected(\.view.factory) static var factory
    
    static var previews: some View {
        ContentView(viewModel: factory.newContentVM())
            .preview
    }
}
