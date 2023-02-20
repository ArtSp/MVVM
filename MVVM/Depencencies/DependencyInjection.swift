
import Foundation

final class DependencyInjection {
    
    private(set) var view: ViewInjectionProtocol
    private(set) var viewModel: ViewModelInjectionProtocol
    
    enum Preset {
        case `default`, mock
    }
    
    convenience init(
        preset: Preset
    ) {
        switch preset {
        case .default:
            self.init(
                view: ViewInjection(),
                viewModel: ViewModelInjection(appState: .shared)
            )
            
        case .mock:
            self.init(
                view: ViewInjection(),
                viewModel: ViewModelInjectionMock(appState: .shared)
            )
        }
    }
    
    private init(
        view: ViewInjectionProtocol,
        viewModel: ViewModelInjectionProtocol
    ) {
        self.view = view
        self.viewModel = viewModel
    }
    
    static func assemble(
        _ preset: Preset
    ) {
        assembly = .init(preset: preset)
    }
    
    static var assembly: DependencyInjection = {
        .init(preset: ProcessInfo.processInfo.isRunningForPreviews ? .mock : .default)
    }()
}

private extension ProcessInfo {
    
    var isRunningForPreviews: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
