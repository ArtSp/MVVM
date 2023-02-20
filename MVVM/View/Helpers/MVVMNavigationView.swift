
import MPSwiftUI
import SwiftUI

// MARK: - PeaNavigationView

struct MVVMNavigationView<Content: View>: View {
    
    var content: () -> Content
    
    var wrappedContent: some View {
        content()
            .onAppearSetNavBarStyle(.default)
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                wrappedContent
            }
        } else {
            NavigationView {
                wrappedContent
            }
            .navigationViewStyle(.stack)
        }
    }
    
}

// MARK: - NavigationBarStyle

enum NavigationBarStyle: String, Codable, CaseIterable {
    case `default`
    
    var standardAppearance: NavigationBarStyleSettings {
        switch self {
        case .default:
            return .init(
                titleTextAttributes: [
                    .foregroundColor: Color.mvvmSystemText.uiColor,
                ],
                largeTitleTextAttributes: [
                    .foregroundColor: Color.mvvmSystemText.uiColor
                ],
                uiFont: nil,
                backImage: Self.defaultNavigationBarBackImage,
                tintColor: Color.mvvmSystemGray,
                backgroundColor: Color.mvvmSystemBackground.uiColor,
                shadowColor: nil,
                backgroundConfig: .opaque
            )
        }
        
    }
    
    var scrollEdgeAppearance: NavigationBarStyleSettings? {
        switch self {
        case .default:
            return .init(
                titleTextAttributes: [
                    .foregroundColor :Color.mvvmSystemText.uiColor,
                ],
                largeTitleTextAttributes: [
                    .foregroundColor: Color.mvvmSystemText.uiColor,
                ],
                uiFont: nil,
                backImage: Self.defaultNavigationBarBackImage,
                tintColor:  Color.mvvmSystemGray,
                backgroundColor: .clear,
                shadowColor: nil,
                backgroundConfig: .transparent
            )
        }
    }
}

extension NavigationBarStyle {
    static var defaultNavigationBarBackImage: UIImage? { UIImage(systemName: "arrow.backward") }
}

// MARK: - NavAppearance

extension NavAppearance {
    init(
        settings: NavigationBarStyleSettings
    ) {
        self.init(
            titleTextAttributes: settings.titleTextAttributes,
            largeTitleTextAttributes: settings.largeTitleTextAttributes,
            tintColor: settings.tintColor?.uiColor,
            shadowColor: settings.shadowColor,
            backgroundColor: settings.backgroundColor,
            backImage: settings.backImage,
            backgroundConfig: settings.backgroundConfig)
    }
}

struct NavigationBarStyleSettings {
    var titleTextAttributes: [NSAttributedString.Key: Any]
    var largeTitleTextAttributes: [NSAttributedString.Key: Any]
    var uiFont: UIFont?
    var backImage: UIImage?
    var tintColor: Color?
    var backgroundColor: UIColor?
    var shadowColor: UIColor?
    var backgroundConfig: NavAppearance.BackgroudConfiguration
}

// MARK: - NavigationBarStyleModifier

private struct NavigationBarStyleModifier: ViewModifier {
    
    @State var style: NavigationBarStyle

    func body(
        content: Content
    ) -> some View {
        content
            .navigationBarStyle(
                standardAppearance: .init(settings: style.standardAppearance),
                compactAppearance: .init(settings: style.standardAppearance),
                scrollEdgeAppearance: .init(settings: style.scrollEdgeAppearance ?? style.standardAppearance),
                tintColor: style.standardAppearance.tintColor ?? Color.black
            )
    }
}

private extension View {
    
    /// Sets navigation bar style when view appers
    ///
    /// - Warning:
    /// Use only once per navigation view
    func onAppearSetNavBarStyle(
        _ style: NavigationBarStyle
    ) -> some View {
        self.modifier(NavigationBarStyleModifier(style: style))
    }
}
