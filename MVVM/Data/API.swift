
import Combine

// Here goes API implementation
// For template app let's use someting very simple
enum API {
    
    static func getItems() -> AnyPublisher<[APIModel.Item], Error> {
        let items: [APIModel.Item] = [
            .init(id: .init(), title: "First"),
            .init(id: .init(), title: "Second"),
            .init(id: .init(), title: "Third")
        ]
        return Publishers.sampleRequest(items)
    }
    
}
