
import SwiftUI
import MPSwiftUI

// MARK: - IO

extension OnboardingView: ViewModelView {
    
    struct ViewState {
    }
    
    enum ViewInput {
        case onboardingCompleted
    }
    
}

// MARK: - OnboardingView

struct OnboardingView: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.flow) var flow
    @Preference(\.bundleLanguage) var bundleLanguage
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("onboarding.description")
                .textStyle(.bodyBold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            Button("onboarding.button.start") {
                trigger(.onboardingCompleted)
            }
            .buttonStyle(.mvvmButton())
            .isHidden(flow != .onboarding)
        }
        .padding()
        .scrollViewIfNeeded(.vertical)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("onboarding.navigation.title")
    }
}

// MARK: - Preview

struct OnboardingView_Previews: PreviewProvider {
    @Injected(\.view.factory) static var factory
    
    static var previews: some View {
        Group {
            MVVMNavigationView {
                OnboardingView(viewModel: factory.newOnboardingVM())
            }.flow(.onboarding)
            
            MVVMNavigationView {
                OnboardingView(viewModel: factory.newOnboardingVM())
            }
        }
        .preview
    }
}
