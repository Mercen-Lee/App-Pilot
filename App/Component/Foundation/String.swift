import SwiftUI

extension String {
    
    init(view: APView, completion: () -> String) {
        let modifiers = view.modifier.compactMap {
            if $0.activated && !$0.code.isEmpty {
                $0.code
            } else {
                nil
            }
        }.joined(separator: "\n")
        if modifiers.isEmpty {
            self = completion()
        } else {
            self = "\(completion())\n\(modifiers)"
        }
    }
    
    func colored(_ color: Color) -> AttributedString {
        return AttributedString(self,
                                attributes: .init([.foregroundColor: color]))
    }
}
