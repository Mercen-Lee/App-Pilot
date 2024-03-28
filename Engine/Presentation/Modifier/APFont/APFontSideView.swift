import SwiftUI

struct APFontSideView: View {
    
    @ObservedObject var font: APFont
    
    var body: some View {
        VStack {
            NumberField(value: $font.size)
            Menu {
                ForEach(APFontWeight.allCases, id: \.self) { weight in
                    Button(weight.rawValue) {
                        font.weight = weight
                    }
                }
            } label: {
                Cell {
                    HStack(spacing: 12) {
                        Text(font.weight.rawValue)
                            .fontWeight(font.weight.value)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.title2)
                    }
                }
            }
        }
    }
}
