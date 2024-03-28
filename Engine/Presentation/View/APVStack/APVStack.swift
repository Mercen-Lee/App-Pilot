import SwiftUI

final class APVStack: APStack {
    
    @Published var alignment: HorizontalAlignment
    
    init(alignment: HorizontalAlignment = .center,
         spacing: CGFloat = 10,
         @APViewBuilder items: () -> [APView]) {
        self.alignment = alignment
        super.init(type: "VStack", spacing: spacing, items: items())
    }
    
    override var displayName: String {
        "Vertical Stack"
    }
    
    override var alignmentText: String {
        switch alignment {
        case .leading: ".leading"
        case .trailing: ".trailing"
        default: ".center"
        }
    }
    
    override func body(draft: Bool = false,
                       selected: Binding<APObject>? = nil) -> AnyView {
        .init(draft, view: self, selected: selected) { [self] in
            VStack(alignment: alignment,
                   spacing: CGFloat(spacing)) {
                ForEach(items, id: \.id) { item in
                    item.body(draft: draft, selected: selected)
                }
            }
        }
    }
    
    override func sideView() -> AnyView {
        .init(modifier: modifier) {
            APVStackSideView(vStack: self)
        }
    }
}
