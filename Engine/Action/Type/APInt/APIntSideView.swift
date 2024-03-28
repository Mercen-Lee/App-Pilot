import SwiftUI

struct APIntSideView: View {
    
    @ObservedObject var int: APInt
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Variable Identifier") {
                Cell {
                    TextField("Identifier", text: $int.name)
                }
            }
            Stripe(.horizontal)
            TitledView("Default Value") {
                let binding = Binding(get: { CGFloat(int.value as! Int) },
                                      set: { int.value = Int(round($0)) })
                NumberField(value: binding)
            }
        }
    }
}
