import Foundation
import Combine

class APStack: APView {
    
    @Published var items: [APView]
    @Published var spacing: CGFloat
    var alignmentText: String { .init() }
    
    init(type: String, spacing: CGFloat, items: [APView]) {
        self.spacing = spacing
        self.items = items
        super.init(type: type)
    }
    
    override var code: String {
        .init(view: self) {
            let params = ["alignment: \(alignmentText)",
                          "spacing: \(spacing)"]
                .joined(separator: ", ")
            var lines = ["\(type)(\(params)) {"]
            items.forEach { item in
                lines.append("\(item.code)")
            }
            lines += ["}"]
            return lines.joined(separator: "\n")
        }
    }
}
