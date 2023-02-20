
import Combine

class ContentViewModel: ViewModelBase<ContentView> {
    
    @Injected(\.viewModel.appState) private var appState
    @Injected(\.viewModel.apiService) private var apiService
    
    init() {
        super.init(state: .init())
    }
    
    override var bindings: [AnyCancellable] {
        [
            appState.$items.sinkValue { [weak self] items in
                self?.state.items = items
            },
            appState.$onboardingCompleted.publisher.sinkValue { [weak self] onboardingCompleted in
                self?.state.onboardingCompleted = onboardingCompleted
            },
        ]
    }
    
    func loadItems() {
        apiService.getItems()
            .handleLoading(in: self, keyPath: \.state.isLoading, event: .items)
            .sinkValue { [weak self] items in
                self?.appState.items = items
            }
            .store(in: &cancelables)
    }
    
    override func trigger(
        _ input: ContentView.ViewInput
    ) {
        switch input {
        case .loadItems:
            loadItems()
            
        case .resetOnboarding:
            appState.onboardingCompleted = false
        }
    }
    
}
