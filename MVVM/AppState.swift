
import Combine

final class AppState: ObservableObject {
    @UserDefault("onboardingCompleted") var onboardingCompleted: Bool = false
    @Published var items: [Item]?
    
    private init() {}
    static let shared = AppState()
}
