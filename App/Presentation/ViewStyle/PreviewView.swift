import SwiftUI

struct PreviewView: View {
    
    @EnvironmentObject var state: RootState
    @State var count: Int = 0
    @State var isPresented: Bool = false
    
    @ViewBuilder
    func makeButton(_ height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.stripe)
            .frame(width: 10, height: height)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                state.selectedScreen.body.body()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                    .background(Color(.systemBackground))
                    .clipped()
            }
            .overlay(Rectangle()
                .strokeBorder(Color.stripe, lineWidth: 2))
            .aspectRatio(9/16, contentMode: .fit)
            .padding(.horizontal, 20)
            .padding(.top, 100)
            Button {
                count += 1
                if count % 3 == 0 {
                    isPresented.toggle()
                    count = 0
                }
            } label: {
                Circle()
                    .strokeBorder(Color.stripe, lineWidth: 2)
                    .frame(width: 60, height: 60)
            }
            .padding(.vertical, 20)
            .popover(isPresented: $isPresented) {
                Text(":)")
            }
        }
        .background(Color.fill)
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .overlay(RoundedRectangle(cornerRadius: 50)
            .strokeBorder(Color.stripe, lineWidth: 2))
        .background(
            HStack {
                VStack {
                    makeButton(30)
                        .padding(.bottom, 20)
                    makeButton(60)
                    makeButton(60)
                }
                Spacer()
                makeButton(60)
            }
                .padding(.horizontal, -5)
                .padding(.top, 100)
            , alignment: .top)
    }
}
