import SwiftUI

struct APVStackSideView: View {
    
    @ObservedObject var vStack: APVStack
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Alignment") {
                SelectionView(selected: $vStack.alignment, selections: [
                    .init("Leading", data: .leading) {
                        Image(systemName: "align.horizontal.left.fill")
                    },
                    .init("Center", data: .center) {
                        Image(systemName: "align.horizontal.center.fill")
                    },
                    .init("Trailing", data: .trailing) {
                        Image(systemName: "align.horizontal.right.fill")
                    }
                ])
            }
            Stripe(.horizontal)
            TitledView("Spacing") {
                NumberField(value: $vStack.spacing)
            }
        }
    }
}
