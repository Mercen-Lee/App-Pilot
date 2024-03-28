import SwiftUI

struct StateListView: View {
    
    @EnvironmentObject var state: RootState
    
    @State var newStatePresented: Bool = false
    @State var draggedState: APVariable?
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(state.selectedScreen.state.indices, id: \.self) { idx in
                let contentState = state.selectedScreen.state[idx]
                let selected = state.selectedComponent == contentState
                Button {
                    state.selectedComponent = selected ? APNone() : contentState
                } label: {
                    Cell(selected: selected, infinityWidth: true) {
                        HStack {
                            Text("\(contentState.type)")
                                .opacity(0.5)
                            Text("\(contentState.name)")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder({ () -> Color in
                                contentState == draggedState ? .accent : .clear
                            }(), lineWidth: 2)
                    )
                }
                .onDrag {
                    draggedState = contentState
                    return NSItemProvider()
                } preview: {
                    Color.clear
                        .frame(width: 0.5, height: 0.5)
                }
                .onDrop(of: [.text],
                        delegate: StateDropDelegate(destinationState: contentState,
                                                    states: $state.selectedScreen.state,
                                                    draggedState: $draggedState)
                )
            }
            Button {
                newStatePresented.toggle()
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
            .popover(isPresented: $newStatePresented) {
                NewStateView()
                    .environmentObject(state)
            }
        }
    }
}
