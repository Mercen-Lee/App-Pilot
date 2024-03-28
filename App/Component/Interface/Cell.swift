import SwiftUI

struct Cell<C: View>: View {
    
    let selected: Bool
    let infinityWidth: Bool
    let removePadding: Bool
    let content: () -> C
    
    init(selected: Bool = false,
         infinityWidth: Bool = false,
         removePadding: Bool = false,
         @ViewBuilder content: @escaping () -> C) {
        self.selected = selected
        self.infinityWidth = infinityWidth
        self.removePadding = removePadding
        self.content = content
    }
    
    var body: some View {
        content()
            .frame(minHeight: 26)
            .font(.title3)
            .foregroundStyle(selected ? Color.white : .label)
            .padding(.vertical, removePadding ? 0 : 12)
            .padding(.horizontal, removePadding ? 0 : 20)
            .frame(maxWidth: infinityWidth ? .infinity : .none)
            .background(selected ? Color.accent : .cell)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .animation(.none, value: selected)
    }
}
