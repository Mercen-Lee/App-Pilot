import SwiftUI

final class APSpacer: APView {
    
    init() {
        super.init(type: "Spacer")
    }
    
    override func body(draft: Bool = false,
                       selected: Binding<APObject>? = nil) -> AnyView {
        .init(draft, view: self, selected: selected) {
            Spacer()
        }
    }
    
    override func sideView() -> AnyView {
        .init(modifier: modifier) { }
    }
    
    override var code: String {
        .init(view: self) {
            "Spacer()"
        }
    }
}
