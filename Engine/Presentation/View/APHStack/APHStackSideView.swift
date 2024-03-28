import SwiftUI

struct APHStackSideView: View {
    
    @ObservedObject var hStack: APHStack
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Alignment") {
                SelectionView(selected: $hStack.alignment, selections: [
                    .init("Top", data: .top) {
                        Image(systemName: "align.vertical.top.fill")
                    },
                    .init("Center", data: .center) {
                        Image(systemName: "align.vertical.center.fill")
                    },
                    .init("Bottom", data: .bottom) {
                        Image(systemName: "align.vertical.bottom.fill")
                    }
                ])
            }
            Stripe(.horizontal)
            TitledView("Spacing") {
                NumberField(value: $hStack.spacing)
            }
        }
    }
}
