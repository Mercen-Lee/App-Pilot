import SwiftUI
import Combine

class APView: APObject {
    
    let modifier: [APModifier] = [APFont(),
                                  APForeground(),
                                  APFrame(),
                                  APPadding()]
    var subscriptions: [AnyCancellable] = []
    var code: String { .init() }
    var displayName: String { super.type }
    
    override init(type: String) {
        super.init(type: type)
        self.subscriptions = self.modifier.map { modifier in
            modifier.objectWillChange
                .sink { [weak self] _ in
                    self?.objectWillChange.send()
                }
        }
    }
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
    }
    
    func body(draft: Bool = false,
              selected: Binding<APObject>? = nil) -> AnyView {
        .init(EmptyView())
    }
    
    func font(_ size: CGFloat, weight: APFontWeight) -> APView {
        let modifier = self.modifier[0] as! APFont
        modifier.size = size
        modifier.weight = weight
        modifier.activated = true
        return self
    }
    
    func foregroundColor(_ color: Color) -> APView {
        let modifier = self.modifier[1] as! APForeground
        modifier.color = color
        modifier.activated = true
        return self
    }
    
    func padding(leading: CGFloat = 0,
                 trailing: CGFloat = 0,
                 top: CGFloat = 0,
                 bottom: CGFloat = 0) -> APView {
        let modifier = self.modifier[3] as! APPadding
        modifier.leading = leading
        modifier.trailing = trailing
        modifier.top = top
        modifier.bottom = bottom
        modifier.activated = true
        return self
    }
}
