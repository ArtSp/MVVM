
import Foundation

//MARK: - ViewInjectionProtocol

protocol ViewInjectionProtocol  {
    var factory: ViewModelFactoryProtocol { get }
}

//MARK: - ViewInjection

class ViewInjection: ViewInjectionProtocol {
    
    lazy private(set) var factory: ViewModelFactoryProtocol = ViewModelFactory()
    
}
