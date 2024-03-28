import SwiftUI

struct APBoolSideView: View {
    
    @ObservedObject var bool: APBool
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Variable Identifier") {
                Cell {
                    TextField("Identifier", text: $bool.name)
                }
            }
            Stripe(.horizontal)
            TitledView("Default Value") {
                let binding = Binding(get: { bool.value as! Bool },
                                      set: { bool.value = $0 })
                SelectionView(selected: binding, selections: [
                    .init("True", data: true) {
                        Text("true")
                    },
                    .init("False", data: false) {
                        Text("false")
                    }
                ])
            }
        }
    }
}
