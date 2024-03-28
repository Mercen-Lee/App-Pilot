import Foundation

@resultBuilder
struct APViewBuilder {
    
    static func buildBlock(_ apView: APView...) -> [APView] {
        apView
    }
}
