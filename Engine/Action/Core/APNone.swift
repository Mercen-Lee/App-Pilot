import SwiftUI

class APNone: APObject {
    
    init() {
        super.init(type: "None")
    }
    
    override func sideView() -> AnyView { .init(
        Text("Select State or View")
            .frame(maxHeight: .infinity)
            .fontWeight(.bold)
    )}
}
