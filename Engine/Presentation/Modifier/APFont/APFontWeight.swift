import SwiftUI

enum APFontWeight: String, CaseIterable {
    
    case ultraLight = "Ultra Light"
    case thin = "Thin"
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
    case heavy = "Heavy"
    case black = "Black"
    
    var presentation: String {
        switch self {
        case .ultraLight: "ultraLight"
        case .thin: "thin"
        case .light: "light"
        case .regular: "regular"
        case .medium: "medium"
        case .semibold: "semibold"
        case .bold: "bold"
        case .heavy: "heavy"
        case .black: "black"
        }
    }
    
    var value: Font.Weight {
        switch self {
        case .ultraLight: .ultraLight
        case .thin: .thin
        case .light: .light
        case .regular: .regular
        case .medium: .medium
        case .semibold: .semibold
        case .bold: .bold
        case .heavy: .heavy
        case .black: .black
        }
    }
}
