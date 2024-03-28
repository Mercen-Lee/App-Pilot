import SwiftUI

struct CodeView: View {
    
    @EnvironmentObject var state: RootState
    
    let size: CGSize
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            let minus = state.isDeviceHorizontal ? 600.0 : 0
            VStack(alignment: .leading) {
                let lines = state.selectedScreen.code.components(separatedBy: "\n")
                ForEach(lines.indices, id: \.self) { idx in
                    HStack(alignment: .top, spacing: 15) {
                        Text("\(idx)")
                            .font(.callout)
                            .monospacedDigit()
                            .foregroundStyle(Color.gray)
                            .frame(width: 40, alignment: .trailing)
                        Text(lines[idx])
                            .monospaced()
                    }
                }
                Spacer()
                    .font(.title)
            }
            .padding([.vertical, .trailing], 20)
            .frame(minWidth: size.width - minus, alignment: .leading)
            .frame(maxWidth: size.width, minHeight: size.height)
        }
    }
}
