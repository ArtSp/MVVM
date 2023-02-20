
import Combine

class ViewModelBase<V: ViewModelView>: NSObject, ViewModelObject {
    
    @Published var state: V.ViewState
    var bindings: [AnyCancellable] { [] }
    
    init(
        state: V.ViewState
    ) {
        self.state = state
        super.init()
        bind()
        print("🐣 init \(String(describing: self))")
    }
    
    deinit {
        print("☠️ deinit \(String(describing: self))")
    }
    
    final func bind() {
        bindings.forEach { $0.store(in: &cancelables) }
    }
    
    func trigger(
        _ input: V.ViewInput
    ) {
        fatalError(.notImplemented)
    }
}
