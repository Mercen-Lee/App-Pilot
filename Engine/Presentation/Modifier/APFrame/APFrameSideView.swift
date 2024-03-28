import SwiftUI

struct APFrameSideView: View {
    
    @ObservedObject var frame: APFrame
    
    struct OptionalField: View {
        
        let title: String
        let symbol: String?
        @Binding var value: CGFloat?
        
        init(_ title: String,
             symbol: String? = nil,
             value: Binding<CGFloat?>) {
            self.title = title
            self.symbol = symbol
            self._value = value
        }
        
        var body: some View {
            VStack {
                HStack(spacing: 5) {
                    if let symbol {
                        Image(systemName: symbol)
                    }
                    Text(title)
                        .fontWeight(symbol != nil ? .bold : nil)
                    Spacer()
                    if value != nil {
                        Button {
                            value = nil
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .foregroundStyle(Color.label)
                    }
                }
                if let unwrappedValue = value {
                    NumberField(value: Binding(get: { unwrappedValue },
                                               set: { value = $0 }))
                } else {
                    Button {
                        value = 0
                    } label: {
                        NumberField(value: .constant(0))
                            .disabled(true)
                            .opacity(0.4)
                    }
                }
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(spacing: 10) {
                OptionalField("Width",
                              symbol: "arrow.left.and.right",
                              value: $frame.width)
                OptionalField("Minimum", value: $frame.minWidth)
                OptionalField("Maximum", value: $frame.maxWidth)
            }
            VStack(spacing: 10) {
                OptionalField("Height",
                              symbol: "arrow.up.and.down",
                              value: $frame.height)
                OptionalField(" ", value: $frame.minHeight)
                OptionalField(" ", value: $frame.maxHeight)
            }
        }
        .padding(.top, 5)
    }
}
