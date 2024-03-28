import SwiftUI

struct APFloatSideView: View {
    
    @ObservedObject var float: APFloat
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Variable Identifier") {
                Cell {
                    TextField("Identifier", text: $float.name)
                }
            }
            Stripe(.horizontal)
            TitledView("Default Value") {
                let binding = Binding(get: { float.value as! CGFloat },
                                      set: { float.value = $0 })
                NumberField(value: binding)
            }
        }
    }
}
