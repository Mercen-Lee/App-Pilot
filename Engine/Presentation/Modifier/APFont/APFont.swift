import SwiftUI

class APFont: APModifier {
    
    @Published var size: CGFloat = 17
    @Published var weight: APFontWeight = .regular
    
    init() {
        super.init(type: "Font")
    }
    
    override func combineView(_ view: AnyView) -> AnyView { .init(
        view
            .font(.system(size: size, weight: weight.value))
    )}
    
    override var code: String {
        ".font(.system(size: \(size), weight: .\(weight.presentation)))"
    }
    
    override func sideView() -> AnyView { .init(
        APFontSideView(font: self)
    )}
}
