
import MPSwiftUI

extension TextStyle {
    
    static let headline: TextStyle      = .init(.system(.headline))
    static let subheadline: TextStyle   = .init(.system(.subheadline))
    static let body: TextStyle          = .init(.system(.body))
    static let bodyBold: TextStyle      = .init(.system(.body, weight: .bold))
    static let caption: TextStyle       = .init(.system(.caption))
    static let button: TextStyle        = .init(.system(.title3, design: .rounded, weight: .heavy))
    
}
