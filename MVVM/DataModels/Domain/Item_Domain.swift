
import Foundation

typealias Item = DomainModel.Item

extension DomainModel {
    struct Item: Identifiable {
        let id: ID
        let name: String
    }
}

extension Item: PlaceholderProvider {
    static var placeholder: Self { .init(id: .init(), name: "Name") }
}

extension Item {
    static let fakes: [Self] = [
        .init(id: .init(), name: "First_Mock"),
        .init(id: .init(), name: "Second_Mock"),
        .init(id: .init(), name: "Third_Mock"),
    ]
}
