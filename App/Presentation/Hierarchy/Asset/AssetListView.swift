import SwiftUI

struct AssetListView: View {
    
    @EnvironmentObject var state: RootState
    
    @State var newAssetPresented: Bool = false
    @State var draggedAsset: APAsset?
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(state.app.assets.indices, id: \.self) { idx in
                let asset = state.app.assets[idx]
                let selected = state.selectedComponent == asset
                Button {
                    state.selectedComponent = selected ? APNone() : asset
                } label: {
                    Cell(selected: selected, infinityWidth: true) {
                        HStack {
                            Image(uiImage: asset.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .strokeBorder({ () -> Color in
                                            selected ? .white : .label
                                        }(), lineWidth: 2)
                                )
                                .padding(.vertical, -5)
                            Text("\(asset.name)")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder({ () -> Color in
                                asset == draggedAsset ? .accent : .clear
                            }(), lineWidth: 2)
                    )
                }
                .onDrag {
                    draggedAsset = asset
                    return NSItemProvider()
                } preview: {
                    Color.clear
                        .frame(width: 0.5, height: 0.5)
                }
                .onDrop(of: [.text],
                        delegate: AssetDropDelegate(destinationAsset: asset,
                                                    assets: $state.app.assets,
                                                    draggedAsset: $draggedAsset)
                )
            }
            Button {
                newAssetPresented.toggle()
            } label: {
                Cell {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundStyle(Color.accent)
                        .frame(width: 20, height: 20)
                        .padding(2)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .popover(isPresented: $newAssetPresented) {
                NewAssetView()
                    .environmentObject(state)
            }
        }
    }
}
