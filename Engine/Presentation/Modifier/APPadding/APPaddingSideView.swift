import SwiftUI

struct APPaddingSideView: View {
    
    @ObservedObject var padding: APPadding
    
    var body: some View {
        VStack {
            NumberField(value: $padding.top)
                .frame(width: 110)
            HStack {
                NumberField(value: $padding.leading)
                    .frame(width: 110)
                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                    .imageScale(.large)
                    .frame(maxWidth: .infinity)
                NumberField(value: $padding.trailing)
                    .frame(width: 110)
            }
            NumberField(value: $padding.bottom)
                .frame(width: 110)
        }
    }
}
