
import MPSwiftUI

extension View {
    
    var preview: some View {
        self.viewDefaults
            .localePreview(locales: Language.allCases.map { $0.locale })
    }
    
    var viewDefaults: some View {
        self.tint(.mvvmSystemGreen)
    }
    
    var localizedByBundle: some View {
        self.modifier(BundleLocalizationModifier())
    }
}


// MARK: - Helpers

private struct BundleLocalizationModifier: ViewModifier {
    
    @Preference(\.bundleLanguage) var bundleLanguage
    
    func body(
        content: Content
    ) -> some View {
        content
            .locale(bundleLanguage.locale)
    }
}
