import SwiftUI

struct APStringSideView: View {
    
    @ObservedObject var string: APString
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Variable Identifier") {
                Cell {
                    TextField("Identifier", text: $string.name)
                }
            }
            Stripe(.horizontal)
            TitledView("Default Value") {
                Cell {
                    let binding = Binding(get: { string.value as! String },
                                          set: { string.value = $0 })
                    TextField("Value", text: binding)
                }
            }
        }
    }
}
