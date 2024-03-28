import SwiftUI

struct APTextSideView: View {
    
    @ObservedObject var text: APText
    @EnvironmentObject var screen: APScreen
    
    struct APTextCell<C: View>: View {
        
        typealias APTextType = APText.APTextType
        
        @EnvironmentObject var text: APText
        let value: APTextType
        let preview: () -> C
        
        init(_ value: APTextType,
             @ViewBuilder preview: @escaping () -> C) {
            self.value = value
            self.preview = preview
        }
        
        func makeColor(_ defaultColor: Color) -> Color {
            text.value == value ? .accent : defaultColor
        }
        
        var body: some View {
            Button {
                if text.value != value {
                    let savedValue = text.savedValue
                    text.savedValue = text.value
                    text.value = savedValue
                }
            } label: {
                Cell(infinityWidth: true, removePadding: true) {
                    VStack {
                        preview()
                            .font(.system(size: 35, design: .rounded))
                            .frame(height: 70)
                            .foregroundStyle(makeColor(.label))
                        Text(value.name)
                            .font(.title3)
                    }
                    .padding(.vertical, 12)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(makeColor(.clear), lineWidth: 2)
                )
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Presentation Type") {
                HStack {
                    APTextCell(.default("")) {
                        Text("ABC")
                    }
                    APTextCell(.binding(nil)) {
                        Image(systemName: "app.connected.to.app.below.fill")
                    }
                }
                .environmentObject(text)
            }
            Stripe(.horizontal)
            switch text.value {
            case let .default(string):
                TitledView("Fixed Value") {
                    Cell {
                        TextField("Value", text: Binding(get: { string },
                                                         set: { text.value = .default($0) }))
                        .dismissButton()
                    }
                }
            case let .binding(variable):
                TitledView("State Selection") {
                    Menu {
                        ForEach(screen.state, id: \.id) { state in
                            Button(state.name) {
                                text.value = .binding(state)
                            }
                        }
                    } label: {
                        Cell {
                            HStack {
                                if let variable {
                                    Text("\(variable.type)")
                                        .opacity(0.5)
                                }
                                Text(variable?.name ?? "None")
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(2)
                            }
                        }
                    }
                }
            }
        }
    }
}
