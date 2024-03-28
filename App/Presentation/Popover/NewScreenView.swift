import SwiftUI

struct NewScreenView: View {
    
    @EnvironmentObject var state: RootState
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isFocused: Bool
    @State var name: String = ""
    @State var alert: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitledView("Identifier") {
                Cell {
                    TextField("NewView", text: $name)
                        .focused($isFocused)
                        .dismissButton()
                }
            }
            Spacer()
            LargeButton("Create a new View") {
                if name.isEmpty {
                    alert = "Identifier is empty. Let's fill the blank."
                } else if name.contains(" ") {
                    alert = "Identifier should not contain whitespace."
                } else if name.starts(with: try! Regex("^[0-9]")) {
                    alert = "Identifier should not begin with a number."
                } else if state.app.screens.map({ $0.name }).contains(name) {
                    alert = "It's a duplicate identifier."
                } else {
                    state.createNewView(name)
                    dismiss()
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.vertical, 36)
        .padding(.horizontal, 12)
        .frame(minWidth: 500)
        .background(Color.fill.ignoresSafeArea())
        .alert("Wait!", isPresented: Binding(get: { alert != nil },
                                             set: { if !$0 { alert = nil } })) {
            Button("OK") { }
        } message: {
            Text("\(alert ?? "")")
        }
        .onAppear {
            isFocused = true
        }
    }
}
