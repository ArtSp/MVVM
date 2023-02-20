import Combine

class OnboardingViewModel: ViewModelBase<OnboardingView> {
    
    @Injected(\.viewModel.appState) private var appState
    
    init() {
        super.init(state: .init())
    }
    
    override func trigger(
        _ input: OnboardingView.ViewInput
    ) {
        switch input {
        case .onboardingCompleted:
            appState.onboardingCompleted = true
        }
    }
    
}
