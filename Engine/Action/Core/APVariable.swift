import Foundation

class APVariable: APObject {
    
    @Published var name: String
    @Published var value: Any
    
    init(_ name: String, type: String, value: Any) {
        self.name = name
        self.value = value
        super.init(type: type)
    }
    
    var state: String {
        "@State var \(name): \(type) = \(value)"
    }
}
