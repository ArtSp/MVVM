
import Combine

// MARK: - APIServiceProtocol

protocol APIServiceProtocol: AnyObject {
    func getItems() -> AnyPublisher<[Item], Error>
}

// MARK: - APIService

final class APIService: APIServiceProtocol {
    func getItems() -> AnyPublisher<[Item], Error> {
        API.getItems()
            .map { items in items.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}

// MARK: - APIServiceMock

final class APIServiceMock: APIServiceProtocol {
    func getItems() -> AnyPublisher<[Item], Error> {
        Just(Item.fakes)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
