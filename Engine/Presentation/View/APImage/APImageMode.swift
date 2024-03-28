import SwiftUI

enum APImageMode: String {
    
    case `default`
    case fit = "fit"
    case fill = "fill"
    
    var value: ContentMode? {
        switch self {
        case .default: nil
        case .fit: .fit
        case .fill: .fill
        }
    }
}
