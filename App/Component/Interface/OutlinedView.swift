import SwiftUI

struct OutlinedView<C: View>: View {
    
    let content: () -> C
    let view: APView
    @Binding var selected: APObject
    
    init(view: APView,
         selected: Binding<APObject>,
         content: @escaping () -> C) {
        self.content = content
        self.view = view
        self._selected = selected
    }
    
    var body: some View {
        Button {
            selected = view
        } label: {
            content()
                .padding(2)
                .overlay(
                    Rectangle()
                        .strokeBorder({
                            selected == view ? Color.accent : .clear
                        }(), lineWidth: 1.5)
                )
                .background(
                    Rectangle()
                        .strokeBorder(Color.stripe, lineWidth: 1.5)
                )
                .padding(-2)
        }
        .buttonStyle(.plain)
    }
}
