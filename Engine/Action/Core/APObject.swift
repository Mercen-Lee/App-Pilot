import SwiftUI

class APObject: Identifiable, Equatable, ObservableObject {
    
    var id: UUID = .init()
    @Published var type: String
    func sideView() -> AnyView { .init(EmptyView()) }
    
    init(type: String) {
        self.type = type
    }
    
    static func == (lhs: APObject, rhs: APObject) -> Bool {
        lhs.id == rhs.id
    }
}
