
import Foundation

enum Language: String, Codable {
    case english = "en"
    case russian = "ru"
    
    init?(
        identifier: String?
    ) {
        guard let id = identifier?.components(separatedBy: "-").first,
              let language = Language(rawValue: id)
        else {
            return nil
        }
        self = language
    }
}

extension Language: Identifiable, CaseIterable {
    
    var locale: Locale { .init(identifier: code) }
    var id: String { code }
    var code: String { rawValue }
    
    var name: String {
        switch self {
        case .english:  return "English"
        case .russian:  return "Русский"
        }
    }
}
