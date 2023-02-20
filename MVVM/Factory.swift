
import Foundation

// MARK: - ViewModelFactoryProtocol

protocol ViewModelFactoryProtocol: AnyObject {
    func newContentVM() -> ContentView.ViewModel
    func newOnboardingVM() -> OnboardingView.ViewModel
}

// MARK: - ViewModelFactory

final class ViewModelFactory: ObservableObject, ViewModelFactoryProtocol {
    
    func newContentVM() -> ContentView.ViewModel {
        ContentViewModel().toAnyViewModel()
    }
    
    func newOnboardingVM() -> OnboardingView.ViewModel {
        OnboardingViewModel().toAnyViewModel()
    }
}
