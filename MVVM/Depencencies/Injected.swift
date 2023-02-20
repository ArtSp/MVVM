
@propertyWrapper
struct Injected<T> {

    private let keyPath: KeyPath<DependencyInjection, T>
    
    var wrappedValue: T {
        DependencyInjection.assembly[keyPath: keyPath]
    }
    
    init(
        _ keyPath: KeyPath<DependencyInjection, T>
    ) {
        self.keyPath = keyPath
    }
}
