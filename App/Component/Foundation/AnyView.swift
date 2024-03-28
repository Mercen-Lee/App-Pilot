import SwiftUI

extension AnyView {
    
    init<C: View>(_ condition: Bool,
                  view: APView,
                  selected: Binding<APObject>?,
                  @ViewBuilder content: @escaping () -> C) {
        var body = AnyView(content())
        view.modifier.forEach {
            if $0.activated {
                body = $0.combineView(body)
            }
        }
        self = { () -> AnyView in
            if let selected, condition && view as? APSpacer == nil {
                .init(OutlinedView(view: view, selected: selected) {
                    body
                })
            } else { .init(body) }
        }()
    }
    
    init<C: View>(modifier: [APModifier],
                  @ViewBuilder content: @escaping () -> C) {
        self = .init(
            VStack(spacing: 0) {
                content()
                ForEach(modifier) { item in
                    Stripe(.horizontal)
                    ConditionalView(item) {
                        item.sideView()
                    }
                }
            }
        )
    }
}
