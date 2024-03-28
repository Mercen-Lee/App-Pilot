import SwiftUI

struct NewViewView: View {
    
    @EnvironmentObject var state: RootState
    
    let items: [Item] = [
        .init(systemIcon: "character.cursor.ibeam",
              title: "Text",
              view: APText(.default(""))),
        .init(systemIcon: "photo.fill",
              title: "Image",
              view: APImage()),
        .init(systemIcon: "squares.below.rectangle",
              title: "Horizontal\nStack",
              view: APHStack { }),
        .init(systemIcon: "squares.leading.rectangle",
              title: "Vertical\nStack",
              view: APVStack { }),
        .init(systemIcon: "arrow.up.left.and.arrow.down.right",
              title: "Spacer",
              view: APSpacer())
    ]
    
    struct Item: Identifiable {
        
        let id = UUID()
        let systemIcon: String
        let title: String
        let view: APView
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(items, id: \.id) { item in
                    Cell {
                        VStack(spacing: 8) {
                            Image(systemName: item.systemIcon)
                                .imageScale(.large)
                                .frame(width: 30, height: 30)
                                .opacity(0.5)
                                .padding(.vertical, 5)
                            Text(item.title)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100)
                    }
                    .onDrag {
                        state.draggedView = item.view
                        withAnimation(.spring(duration: 0.2)) {
                            state.newViewPresented = false
                        }
                        return NSItemProvider()
                    } preview: {
                        Cell {
                            Text(item.view.type)
                        }
                    }
                }
            }
            .padding(12)
        }
        .scrollIndicators(.hidden)
        .background(Color.fill.ignoresSafeArea())
    }
}
