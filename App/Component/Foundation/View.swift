import SwiftUI

extension View {
    
    @ViewBuilder
    func dismissButton() -> some View {
        self
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                        to: nil, from: nil, for: nil)
                    }
                    .foregroundColor(Color.accent)
                }
            }
    }
}
