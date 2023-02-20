import SwiftUI
import MPSwiftUI

extension ButtonStyle where Self == MVVMButtonStyle {
    static func mvvmButton(
        palette: MVVMButtonStyle.Palette = .mvvmGreen,
        disclosure: MVVMButtonStyle.Disclosure? = nil
    ) -> MVVMButtonStyle {
        .init(style: palette.style, disclosure: disclosure)
    }
}

struct MVVMButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.locale) var locale
    let style: Style
    let disclosure: Disclosure?
    
    enum Palette {
        case mvvmGreen
        case mvvmBackground
        case custom(MVVMButtonStyle.Style)
        
        var style: Style {
            switch self {
            case .mvvmGreen:
                return .init(textColor: .init(main: .mvvmWhite, pressedOpacity: 1),
                             backgroundColor: .mvvmSystemGreen)
                
            case .mvvmBackground:
                return .init(textColor: .init(main: .mvvmSystemText, pressedOpacity: 0.5),
                             backgroundColor: .systemBackground)
                
            case let .custom(style):
                return style
            }
        }
    }
    
    struct Style {
        var textColor: ButtonColor
        var backgroundColor: ButtonColor
        var shadowColor: ButtonColor?
    }
    
    enum Disclosure {
        case add
        case confirm
        case forward
        case cancel
        
        var image: Image {
            switch self {
            case .add: return Image(systemName: "plus")
            case .confirm: return Image(systemName: "checkmark")
            case .forward: return Image(systemName: "chevron.forward")
            case .cancel: return Image(systemName: "xmark")
            }
        }
    }
    
    var buttonShape: some Shape {
        Capsule()
    }

    func makeBody(
        configuration: Configuration
    ) -> some View {
        HStack {
            configuration.label
                .frame(maxWidth: .infinity, alignment: disclosure.isNil ? .center : .leading)
            Unwrap(disclosure?.image) { image in
                image
            }
        }
        .padding(18)
        .foregroundColor(style.textColor.color(for: configuration, isEnabled: isEnabled))
        .background(
            style.backgroundColor.color(for: configuration, isEnabled: isEnabled)
        )
        .clipShape(buttonShape)
        .if(let: style.shadowColor) { view, color in
            view.background(buttonShape.stroke(color.color(for: configuration, isEnabled: isEnabled), lineWidth: 3))
        }
        .textStyle(.button)
    }
}
