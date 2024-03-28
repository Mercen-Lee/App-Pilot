import SwiftUI

struct NewStateView: View {
    
    @EnvironmentObject var state: RootState
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isFocused: Bool
    @State var name: String = ""
    @State var type: NewStateType = .integer
    @State var alert: String?
    
    enum NewStateType: String, CaseIterable {
        
        case integer = "Integer"
        case float = "Float"
        case string = "String"
        case boolean = "Boolean"
        
        var preview: AnyView {
            switch self {
            case .integer: .init(Text("123"))
            case .float: .init(Text("12.3"))
            case .string: .init(Text("ABC"))
            case .boolean: .init(Image(systemName: "switch.2"))
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitledView("Identifier") {
                Cell {
                    TextField("newState", text: $name)
                        .focused($isFocused)
                        .dismissButton()
                        .textInputAutocapitalization(.never)
                }
            }
            TitledView("Type") {
                HStack {
                    SelectionView(selected: $type, selections:
                                    NewStateType.allCases.map { type in
                        SelectionView.Item(type.rawValue, data: type) { type.preview }
                    })
                }
            }
            Spacer()
            LargeButton("Create a new State") {
                if name.isEmpty {
                    alert = "Identifier is empty. Let's fill the blank."
                } else if name.contains(" ") {
                    alert = "Identifier should not contain whitespace."
                } else if name.starts(with: try! Regex("^[0-9]")) {
                    alert = "Identifier should not begin with a number."
                } else if state.selectedScreen.state.map({ $0.name }).contains(name) {
                    alert = "It's a duplicate identifier."
                } else {
                    var variable: APVariable {
                        switch type {
                        case .integer:
                            APInt(name, value: 0)
                        case .float:
                            APFloat(name, value: 0.0)
                        case .string:
                            APString(name, value: "")
                        case .boolean:
                            APBool(name, value: false)
                        }
                    }
                    state.createNewState(variable)
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
