
import Foundation

typealias ID = UUID

enum DomainModel {}
enum APIModel {}

protocol DomainMappingProtocol {
    associatedtype Model
    func toDomain() -> Model
}

// TODO: extend publisher with 'mapToDomain()' where Value is DomainMappingProtocol
