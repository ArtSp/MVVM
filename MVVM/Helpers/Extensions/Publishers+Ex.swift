
import Combine

extension Publishers {
    
    static func sampleRequest<T>(
        _ data: T,
        delay: TimeInterval = 2
    ) -> AnyPublisher<T, Error> {
        Publishers.FakeRequest(delay: delay)
            .map { data }
            .eraseToAnyPublisher()
    }
    
    private class FakeRequestSubscription<S: Subscriber>: Subscription where S.Input == Void, S.Failure == Error {
        private let session = URLSession.shared
        private let delay: TimeInterval
        private var subscriber: S?
        
        init(
            delay: TimeInterval,
            subscriber: S
        ) {
            self.delay = delay
            self.subscriber = subscriber
            sendRequest()
        }
        
        /// Optionaly Adjust The Demand
        func request(
            _ demand: Subscribers.Demand
        ) { }
        
        func cancel() {
            subscriber = nil
        }
        
        private func sendRequest() {
            guard !subscriber.isNil else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                _ = self.subscriber?.receive(())
                self.subscriber?.receive(completion: .finished)
            }
        }
    }
    
    struct FakeRequest: Publisher {
        typealias Output = Void
        typealias Failure = Error
        
        private let delay: TimeInterval
        
        init(
            delay: TimeInterval
        ) {
            self.delay = delay
        }
        
        func receive<S: Subscriber>(
            subscriber: S
        ) where Self.Failure == S.Failure, Self.Output == S.Input {
                let subscription = FakeRequestSubscription(delay: delay, subscriber: subscriber)
                subscriber.receive(subscription: subscription)
        }
    }
}
