import SwiftUI

struct ViewDropDelegate: DropDelegate {
    
    let updateAction: () -> Void
    let destinationView: APView
    @Binding var rootView: APView
    @Binding var draggedView: APView?
    
    func performDrop(info: DropInfo) -> Bool {
        draggedView = nil
        return true
    }
    
    func searchRoot(_ view: APView,
                    stack: APStack,
                    completion: @escaping (APStack) -> Void) {
        if stack.items.contains(view) {
            completion(stack)
        } else {
            stack.items.forEach {
                if let childStack = $0 as? APStack {
                    searchRoot(view,
                               stack: childStack,
                               completion: completion)
                }
            }
        }
    }
    
    func removeInstance(_ view: APView) -> APView {
        if let stack = rootView as? APStack {
            searchRoot(view, stack: stack) { foundStack in
                foundStack.items.remove(view)
            }
        }
        return view
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedView else { return }
        if draggedView == destinationView { return }
        withAnimation(.spring(duration: 0.2)) {
            if let stack = destinationView as? APStack {
                let instance = removeInstance(draggedView)
                stack.items.insert(instance, at: 0)
                updateAction()
            } else {
                if let stack = rootView as? APStack {
                    searchRoot(destinationView, stack: stack) { foundStack in
                        let fromIndex = foundStack.items.firstIndex(of: draggedView)
                        guard let fromIndex else { return }
                        let toIndex = foundStack.items.firstIndex(of: destinationView)
                        if let toIndex, fromIndex != toIndex {
                            let fromOffsets = IndexSet(integer: fromIndex)
                            let toOffset = toIndex > fromIndex ? (toIndex + 1) : toIndex
                            foundStack.items.move(fromOffsets: fromOffsets, toOffset: toOffset)
                        }
                        updateAction()
                    }
                }
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        .init(operation: .move)
    }
}
