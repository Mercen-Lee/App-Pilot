import SwiftUI

final class APHStack: APStack {
    
    @Published var alignment: VerticalAlignment
    
    init(alignment: VerticalAlignment = .center,
         spacing: CGFloat = 10,
         @APViewBuilder items: () -> [APView]) {
        self.alignment = alignment
        super.init(type: "HStack", spacing: spacing, items: items())
    }
    
    override var displayName: String {
        "Horizontal Stack"
    }
    
    override var alignmentText: String {
        switch alignment {
        case .bottom: ".bottom"
        case .top: ".top"
        default: ".center"
        }
    }
    
    override func body(draft: Bool = false,
                       selected: Binding<APObject>? = nil) -> AnyView {
        .init(draft, view: self, selected: selected) { [self] in
            HStack(alignment: alignment,
                   spacing: spacing) {
                ForEach(items, id: \.id) { item in
                    item.body(draft: draft, selected: selected)
                }
            }
        }
    }
    
    override func sideView() -> AnyView {
        .init(modifier: modifier) {
            APHStackSideView(hStack: self)
        }
    }
}
