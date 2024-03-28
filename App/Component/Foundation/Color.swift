import SwiftUI

extension Color {
    
    static let accent = Color.accentColor
    static let background = Color("Background")
    static let cell = Color("Cell")
    static let fill = Color("Fill")
    static let label = Color("Label")
    static let stripe = Color("Stripe")
    
    var hex: String {
        guard let components = UIColor(self).cgColor.components else {
            return ""
        }
        let result = String(format: "%02lX%02lX%02lX",
                            lroundf(Float(components[0] * 255)),
                            lroundf(Float(components[1] * 255)),
                            lroundf(Float(components[2] * 255)))
        return result
    }
}
