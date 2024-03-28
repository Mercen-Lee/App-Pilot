import SwiftUI

enum ViewStyle: String, CaseIterable {
    
    case draft = "Draft"
    case preview = "Preview"
    case code = "Code"
    
    var systemIcon: String {
        switch self {
        case .draft: "airplane"
        case .preview: "play.circle.fill"
        case .code: "swift"
        }
    }
    
    @ViewBuilder
    func makeCell(state: Binding<Self>) -> some View {
        Button {
            state.wrappedValue = self
        } label: {
            Cell(selected: state.wrappedValue == self) {
                HStack(spacing: 8) {
                    Image(systemName: self.systemIcon)
                    Text(self.rawValue)
                }
            }
        }
    }
}
