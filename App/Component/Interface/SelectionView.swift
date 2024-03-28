import SwiftUI

struct SelectionView<S: Equatable>: View {
    
    @Binding var selected: S
    let selections: [Item<S>]
    
    struct Item<T: Equatable>: Equatable {
        
        let title: String
        let data: T
        var body: AnyView
        
        init<C: View>(_ title: String, data: T, @ViewBuilder body: () -> C) {
            self.title = title
            self.data = data
            self.body = AnyView(body())
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.data == rhs.data
        }
    }
    
    var body: some View {
        HStack {
            ForEach(selections.indices, id: \.self) { idx in
                let item = selections[idx]
                Button {
                    withAnimation(.spring(duration: 0.2)) {
                        if item.data != selected {
                            selected = item.data
                        }
                    }
                } label: {
                    Cell(infinityWidth: true, removePadding: true) {
                        VStack {
                            item.body
                                .font(.system(size: 35, design: .rounded))
                                .frame(height: 70)
                                .foregroundStyle(item.data == selected ? Color.accent : .label)
                            Text(item.title)
                                .font(.title3)
                        }
                        .padding(.vertical, 12)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(item.data == selected ? Color.accent : .clear,
                                          lineWidth: 2)
                    )
                }
            }
        }
    }
}
