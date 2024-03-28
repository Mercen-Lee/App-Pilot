import SwiftUI

struct LargeButton: View {
    
    let title: String
    let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding(12)
                .foregroundStyle(Color.white)
                .background(Color.accent)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
