import SwiftUI

struct APAssetSideView: View {
    
    @ObservedObject var asset: APAsset
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Image Identifier") {
                Cell {
                    TextField("Identifier", text: $asset.name)
                }
            }
            Stripe(.horizontal)
            TitledView("Preview") {
                Image(uiImage: asset.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
