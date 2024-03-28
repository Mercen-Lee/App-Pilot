import SwiftUI

struct APImageSideView: View {
    
    @ObservedObject var image: APImage
    @EnvironmentObject var app: APApp
    
    var body: some View {
        VStack(spacing: 0) {
            TitledView("Asset Selection") {
                Menu {
                    ForEach(app.assets.indices, id: \.self) { idx in
                        let asset = app.assets[idx]
                        Button(asset.name) {
                            image.asset = asset
                        }
                    }
                } label: {
                    Cell {
                        HStack(spacing: 12) {
                            Text(image.asset?.name ?? "None")
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.title2)
                        }
                    }
                }
            }
            Stripe(.horizontal)
            TitledView("Content Mode") {
                SelectionView(selected: $image.mode, selections: [
                    .init("None", data: .default) {
                        Image(systemName: "photo.fill")
                    },
                    .init("Fit", data: .fit) {
                        Image(systemName: "photo.artframe")
                    },
                    .init("Fill", data: .fill) {
                        Image(systemName: "aspectratio.fill")
                    }
                ])
            }
        }
    }
}
