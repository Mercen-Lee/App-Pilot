import SwiftUI

struct AssetDropDelegate: DropDelegate {
    
    let destinationAsset: APAsset
    @Binding var assets: [APAsset]
    @Binding var draggedAsset: APAsset?
    
    func performDrop(info: DropInfo) -> Bool {
        draggedAsset = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedAsset else { return }
        let fromIndex = assets.firstIndex(of: draggedAsset)
        guard let fromIndex else { return }
        let toIndex = assets.firstIndex(of: destinationAsset)
        if let toIndex, fromIndex != toIndex {
            let fromOffsets = IndexSet(integer: fromIndex)
            let toOffset = toIndex > fromIndex ? (toIndex + 1) : toIndex
            withAnimation(.spring(duration: 0.2)) {
                assets.move(fromOffsets: fromOffsets, toOffset: toOffset)
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        .init(operation: .move)
    }
}
