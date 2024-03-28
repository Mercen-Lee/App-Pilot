import SwiftUI

struct ViewTreeView: View {
    
    @EnvironmentObject var state: RootState
    
    @ViewBuilder
    func toTree(_ view: APView) -> some View {
        AnyView(
            VStack(spacing: 8) {
                let selected = state.selectedComponent == view
                Button {
                    state.selectedComponent = selected ? APNone() : view
                } label: {
                    Cell(selected: selected, infinityWidth: true) {
                        Text(view.type)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder({ () -> Color in
                                view == state.draggedView ? .accent : .clear
                            }(), lineWidth: 2)
                    )
                }
                .onDrag {
                    state.draggedView = view
                    return NSItemProvider()
                } preview: {
                    Color.clear
                        .frame(width: 0.5, height: 0.5)
                }
                .onDrop(of: [.text],
                        delegate: ViewDropDelegate(updateAction: state.updateView,
                                                   destinationView: view,
                                                   rootView: $state.selectedScreen.body,
                                                   draggedView: $state.draggedView)
                )
                if let stack = view as? APStack {
                    let items = stack.items
                    if !items.isEmpty {
                        HStack(spacing: 7) {
                            Rectangle()
                                .fill(selected ? Color.accent : .stripe)
                                .frame(width: 2)
                            VStack(spacing: 8) {
                                ForEach(items.indices, id: \.self) { idx in
                                    toTree(items[idx])
                                }
                            }
                        }
                    }
                }
            }
                .fixedSize(horizontal: false, vertical: true)
        )
    }
    
    var body: some View {
        VStack(spacing: 8) {
            toTree(state.selectedScreen.body)
            Button {
                withAnimation(.spring(duration: 0.2)) {
                    state.newViewPresented.toggle()
                }
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
        }
    }
}
