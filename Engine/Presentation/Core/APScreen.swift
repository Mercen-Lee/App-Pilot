import Foundation

class APScreen: APObject {
    
    typealias State = [APVariable]
    
    @Published var name: String
    @Published var state: State
    @Published var body: APView
    
    init(_ name: String, state: State, body: APView) {
        self.name = name
        self.state = state
        self.body = body
        super.init(type: "Screen")
    }
    
    var code: String {
        var prefix = state.map {
            $0.state
        }.joined(separator: "\n")
        if !prefix.isEmpty {
            prefix = "\n\(prefix)\n"
        }
        let code = """
            import SwiftUI
            
            struct \(name): View {
            \(prefix)
            var body: some View {
            \(body.code)
            }
            }
            """
        var result = ""
        var level = 0
        let components = code.components(separatedBy: "\n")
        components.indices.forEach { idx in
            let line = components[idx]
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if trimmedLine.hasSuffix("}") {
                level -= 1
            }
            var count = max(0, level)
            if trimmedLine.starts(with: ".") && !components[idx-1]
                .trimmingCharacters(in: .whitespaces)
                .hasSuffix("}") {
                count += 1
            }
            let space = String(repeating: "    ", count: count)
            result += space + trimmedLine + "\n"
            if trimmedLine.hasSuffix("{") {
                level += 1
            }
        }
        return result
    }
}
