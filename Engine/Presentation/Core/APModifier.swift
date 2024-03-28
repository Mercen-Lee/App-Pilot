import SwiftUI

class APModifier: APObject {
    
    @Published var activated: Bool = false
    
    var code: String { .init() }
    func combineView(_ view: AnyView) -> AnyView { .init(EmptyView()) }
}
