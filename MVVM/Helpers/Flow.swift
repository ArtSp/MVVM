
import SwiftUI

enum Flow {
    case onboarding
}

// MARK: - View helpers

extension EnvironmentValues {
    var flow: Flow? {
        get { self[FlowKey.self] }
        set { self[FlowKey.self] = newValue }
    }
}

private struct FlowKey: EnvironmentKey {
    static let defaultValue: Flow? = nil
}

extension View {
    func flow(
        _ flow: Flow?
    ) -> some View {
        self.environment(\.flow, flow)
    }
}
