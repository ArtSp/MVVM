
import SwiftUI
import MPSwiftUI

extension Color {
    
    // MARK: - Raw
    static let mvvmGreen: Color  = .init(hex: "#5FB87E")
    static let mvvmGray: Color  = .init(hex: "#B4B4B4")
    static let mvvmBlack: Color  = .init(hex: "#1C1C1E")
    static let mvvmWhite: Color  = .init(hex: "#FFFFFF")
    static let mvvmShadow: Color = .black.opacity(0.1)
    
    // MARK: - System
    static let mvvmSystemGreen: Color       = .mvvmGreen
    static let mvvmSystemGray: Color        = .mvvmGray.invertedForDarkMode()
    static let mvvmSystemBlack: Color       = .mvvmBlack
    static let mvvmSystemWhite: Color       = .mvvmWhite
    static let mvvmSystemShadow: Color      = .mvvmGray.opacity(0.2)
    
    static let mvvmSystemBackground: Color   = .init(uiColor: .systemBackground)
    static let mvvmPlaceholderText: Color    = .init(uiColor: .placeholderText)
    static let mvvmSystemText: Color         = .init(light: .black, dark: .white)
    static let mvvmSystemTextInverted: Color = .init(light: .white, dark: .black)
}

// MARK: - Buttons

extension ButtonColor {

    static let mvvmSystemGreen: Self = .init(
        main: .mvvmSystemGreen,
        pressed: .init(hex: "#56A671"),
        disabled: .mvvmSystemGray
    )

    static let systemBackground: Self = .init(main: .mvvmSystemBackground)
    static let clear: Self = .init(main: .clear)
}
