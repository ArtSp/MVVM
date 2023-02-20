
import Foundation

//MARK: - ViewModelInjectionProtocol

protocol ViewModelInjectionProtocol {
    var appState: AppState { get }
    var apiService: APIServiceProtocol { get }
}


//MARK: - ViewModelInjection

final class ViewModelInjection: ViewModelInjectionProtocol {

    let appState: AppState
    lazy private(set) var apiService: APIServiceProtocol = APIService()
    
    init(
        appState: AppState
    ) {
        self.appState = appState
    }
}

//MARK: - ViewModelInjectionMock

final class ViewModelInjectionMock: ViewModelInjectionProtocol {
    
    let appState: AppState
    lazy private(set) var apiService: APIServiceProtocol = APIServiceMock()
    
    init(
        appState: AppState
    ) {
        self.appState = appState
    }
}
