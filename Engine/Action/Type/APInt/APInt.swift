import SwiftUI

class APInt: APVariable {
    
    init(_ name: String, value: Int) {
        super.init(name, type: "Int", value: value)
    }
    
    override func sideView() -> AnyView { .init(
        APIntSideView(int: self)
    )}
}
