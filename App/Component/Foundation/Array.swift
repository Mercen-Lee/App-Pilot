import Foundation

extension Array where Element: AnyObject {
    
    mutating func remove(_ object: Element) {
        if let index = firstIndex(where: { $0 === object }) {
            remove(at: index)
        }
    }
}
