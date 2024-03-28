import SwiftUI

struct NumberField: View {
    
    @Binding var value: CGFloat
    
    @ViewBuilder
    func makeButton(isIncrease: Bool) -> some View {
        Button {
            withAnimation(.spring(duration: 0.2)) {
                if isIncrease {
                    value += 1
                } else {
                    value -= 1
                }
            }
        } label: {
            Image(systemName: "\(isIncrease ? "plus" : "minus")")
                .resizable()
                .scaledToFit()
                .frame(width: 10)
                .frame(maxHeight: .infinity)
                .padding(.leading, isIncrease ? 4 : 8)
                .padding(.trailing, isIncrease ? 8 : 4)
        }
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        return formatter
    }()
    
    var body: some View {
        Cell(removePadding: true) {
            HStack {
                makeButton(isIncrease: false)
                TextField("", value: $value, formatter: formatter)
                    .dismissButton()
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                makeButton(isIncrease: true)
            }
        }
    }
}
