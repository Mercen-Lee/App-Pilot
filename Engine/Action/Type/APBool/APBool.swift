import SwiftUI

class APBool: APVariable {
    
    init(_ name: String, value: Bool) {
        super.init(name, type: "Bool", value: value)
    }
    
    override func sideView() -> AnyView { .init(
        APBoolSideView(bool: self)
    )}
}
