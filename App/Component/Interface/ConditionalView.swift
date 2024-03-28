import SwiftUI

struct ConditionalView<C: View>: View {
    
    @ObservedObject var modifier: APModifier
    let content: () -> C
    
    init(_ modifier: APModifier,
         @ViewBuilder content: @escaping () -> C) {
        self.modifier = modifier
        self.content = content
    }
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.spring) {
                    modifier.activated.toggle()
                }
            } label: {
                HStack {
                    Text(modifier.type)
                        .fontWeight(.bold)
                    Spacer()
                    Group {
                        if modifier.activated {
                            Image(systemName: "checkmark.square.fill")
                                .foregroundStyle(Color.white, Color.accent)
                        } else {
                            Image(systemName: "square")
                                .foregroundStyle(Color.label)
                        }
                    }
                    .imageScale(.large)
                    .padding(.vertical, -3)
                }
            }
            .foregroundStyle(Color.label)
            if modifier.activated {
                content()
            }
        }
        .padding(12)
    }
}
