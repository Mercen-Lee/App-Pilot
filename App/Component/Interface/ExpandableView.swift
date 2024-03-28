import SwiftUI

struct ExpandableView<C: View>: View {
    
    let title: String
    let content: () -> C
    
    init(_ title: String,
         @ViewBuilder content: @escaping () -> C) {
        self.title = title
        self.content = content
    }
    
    @State var expanded: Bool = true
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.spring) {
                    expanded.toggle()
                }
            } label: {
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(expanded ? 180 : 360))
                }
            }
            .foregroundStyle(Color.label)
            if expanded {
                content()
            }
        }
        .padding(12)
    }
}
