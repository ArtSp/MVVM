
import SwiftUI
import MPSwiftUI
@_exported import MPFoundation
@_exported import MPArchitectureMVVM

@main
struct MVVMApp: App {
    
    // swiftlint:disable weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Injected(\.view.factory) private var factory
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: factory.newContentVM())
                .viewDefaults
                .localizedByBundle
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        // Here you can setup dependencies :
//        DependencyInjection.assemble(.mock)
        
        return true
    }
}
