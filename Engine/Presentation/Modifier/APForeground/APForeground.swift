import SwiftUI

class APForeground: APModifier {
    
    @Published var color: Color = .accent
    
    init() {
        super.init(type: "Foreground Style")
    }
    
    override func combineView(_ view: AnyView) -> AnyView { .init(
        view
            .foregroundStyle(color)
    )}
    
    override var code: String {
        ".foregroundStyle(Color(hex: 0x\(color.hex)))"
    }
    
    override func sideView() -> AnyView { .init(
        APForegroundSideView(foreground: self)
    )}
}
