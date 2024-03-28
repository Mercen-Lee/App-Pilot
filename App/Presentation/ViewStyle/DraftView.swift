import SwiftUI

struct DraftView: View {
    
    @EnvironmentObject var state: RootState
    
    var body: some View {
        GeometryReader { proxy in
            state.selectedScreen.body.body(draft: true,
                                           selected: $state.selectedComponent)
            .padding(3)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(width: proxy.size.width / 1.5,
                   height: proxy.size.height / 1.5)
            .fixedSize()
            .clipped()
            .background(Color.fill)
            .background(
                Rectangle()
                    .strokeBorder(Color.stripe, lineWidth: 3)
                    .padding(-1.5)
            )
        }
        .scaleEffect(1.5, anchor: .topLeading)
    }
}
