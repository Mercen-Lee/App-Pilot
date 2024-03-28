import SwiftUI

class APFloat: APVariable {
    
    init(_ name: String, value: CGFloat) {
        super.init(name, type: "Float", value: value)
    }
    
    override func sideView() -> AnyView { .init(
        APFloatSideView(float: self)
    )}
}
