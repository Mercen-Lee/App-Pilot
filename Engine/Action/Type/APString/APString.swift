import SwiftUI

class APString: APVariable {
    
    init(_ name: String, value: String) {
        super.init(name, type: "String", value: value)
    }
    
    override var state: String {
        "@State var \(name): String = \"\(value)\""
    }
    
    override func sideView() -> AnyView { .init(
        APStringSideView(string: self)
    )}
}
