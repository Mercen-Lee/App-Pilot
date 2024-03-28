import SwiftUI

final class APText: APView {
    
    @Published var value: APTextType
    @Published var savedValue: APTextType
    
    init(_ value: APTextType) {
        self.value = value
        let condition = value == .default("")
        self.savedValue = condition ? .binding(nil) : .default("")
        super.init(type: "Text")
    }
    
    enum APTextType: Equatable {
        
        case `default`(String)
        case binding(APVariable?)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch(lhs, rhs) {
            case (.default, .default), (.binding, .binding): true
            default: false
            }
        }
        
        var presentation: String {
            switch self {
            case let .default(string): string
            case let .binding(variable):
                "\(variable?.value ?? "")"
            }
        }
        
        var code: String {
            switch self {
            case let .default(string): "\"\(string)\""
            case let .binding(variable):
                "\"\\(\(variable?.name ?? "\"\""))\""
            }
        }
        
        var name: String {
            switch self {
            case .default: "Fixed"
            case .binding: "Bind State"
            }
        }
    }
    
    override func body(draft: Bool = false,
                       selected: Binding<APObject>? = nil) -> AnyView {
        .init(draft, view: self, selected: selected) { [self] in
            Text(value.presentation)
        }
    }
    
    override func sideView() -> AnyView {
        .init(modifier: modifier) {
            APTextSideView(text: self)
        }
    }
    
    override var code: String {
        .init(view: self) {
            "Text(\(value.code))"
        }
    }
}
