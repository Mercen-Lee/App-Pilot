import SwiftUI

struct TitledView<C: View>: View {
    
    let title: String
    let content: () -> C
    
    init(_ title: String,
         @ViewBuilder content: @escaping () -> C) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            content()
        }
        .padding(12)
    }
}
