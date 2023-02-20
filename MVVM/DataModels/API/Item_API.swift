
import Foundation

extension APIModel {
    struct Item: Decodable {
        let id: ID
        let title: String
    }
}

extension APIModel.Item: DomainMappingProtocol {
    func toDomain() -> DomainModel.Item {
        .init(
            id: id,
            name: title
        )
    }
}
