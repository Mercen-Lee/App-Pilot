import SwiftUI

struct APForegroundSideView: View {
    
    @ObservedObject var foreground: APForeground
    
    var body: some View {
        Cell {
            HStack {
                Text("#\(foreground.color.hex)")
                Spacer()
                ColorPicker("", selection: $foreground.color)
                    .labelsHidden()
                    .padding(.vertical, -10)
            }
        }
    }
}
