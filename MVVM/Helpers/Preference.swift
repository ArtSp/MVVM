
import Combine
import MPSwiftUI
import SwiftUI


// Class for storing all app preferences
final class Preferences {
    
    static let shared = Preferences()
    private init() {}
    
    /// Sends through the changed key path whenever a change occurs.
    fileprivate var preferencesChangedSubject = PassthroughSubject<AnyKeyPath, Never>()

    var bundleLanguage: Language {
        get { Bundle.language ?? Language.allCases.first! }
        set { Bundle.setLanguage(newValue) }
    }
}

/// Preperty wrapper that allows to notify swiftUI about property changes
@propertyWrapper
struct Preference<Value>: DynamicProperty {
    
    @ObservedObject private var preferencesObserver: PublisherObservableObject
    private let keyPath: ReferenceWritableKeyPath<Preferences, Value>
    private let preferences: Preferences = .shared
    
    init(
        _ keyPath: ReferenceWritableKeyPath<Preferences, Value>
    ) {
        self.keyPath = keyPath
        let publisher = preferences
            .preferencesChangedSubject
            .filter { changedKeyPath in
                changedKeyPath == keyPath
            }
            .mapToVoid()
            .eraseToAnyPublisher()
        self.preferencesObserver = .init(publisher: publisher)
    }
    
    var wrappedValue: Value {
        get {
            if Thread.isMainThread {
                return value
            } else {
                return DispatchQueue.main.sync { value }
            }
        }
        nonmutating set {
            if Thread.isMainThread {
                value = newValue
            } else {
                DispatchQueue.main.sync { value = newValue }
            }
        }
    }
    
    private var value: Value {
        get {
            preferences[keyPath: keyPath]
        }
        nonmutating set {
            preferences[keyPath: keyPath] = newValue
            preferences.preferencesChangedSubject.send(keyPath)
        }
    }
    
    var publisher: AnyPublisher<Value, Never> {
        preferences
            .preferencesChangedSubject
            .filter { changedKeyPath in
                changedKeyPath == self.keyPath
            }
            .mapToVoid()
            .merge(with: Just(())) // Emit current value
            .map { _ in preferences[keyPath: keyPath] }
            .eraseToAnyPublisher()
    }
    
    var binding: Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 }
        )
    }
    
    public var projectedValue: Preference<Value> {
        self
    }
    
}
