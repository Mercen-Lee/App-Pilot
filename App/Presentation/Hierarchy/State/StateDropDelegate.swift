import SwiftUI

struct StateDropDelegate: DropDelegate {
    
    let destinationState: APVariable
    @Binding var states: [APVariable]
    @Binding var draggedState: APVariable?
    
    func performDrop(info: DropInfo) -> Bool {
        draggedState = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedState else { return }
        let fromIndex = states.firstIndex(of: draggedState)
        guard let fromIndex else { return }
        let toIndex = states.firstIndex(of: destinationState)
        if let toIndex, fromIndex != toIndex {
            let fromOffsets = IndexSet(integer: fromIndex)
            let toOffset = toIndex > fromIndex ? (toIndex + 1) : toIndex
            withAnimation(.spring(duration: 0.2)) {
                states.move(fromOffsets: fromOffsets, toOffset: toOffset)
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        .init(operation: .move)
    }
}
