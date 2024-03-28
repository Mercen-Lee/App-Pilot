import SwiftUI

class APPadding: APModifier {
    
    @Published var leading: CGFloat = 0
    @Published var trailing: CGFloat = 0
    @Published var top: CGFloat = 0
    @Published var bottom: CGFloat = 0
    
    init() {
        super.init(type: "Padding")
    }
    
    override func combineView(_ view: AnyView) -> AnyView { .init(
        view
            .padding(.leading, leading)
            .padding(.trailing, trailing)
            .padding(.top, top)
            .padding(.bottom, bottom)
    )}
    
    override var code: String {
        var firstFilter = [(String, CGFloat)]()
        if leading == trailing && trailing == top && top == bottom {
            firstFilter.append((".all", leading))
        } else {
            if leading == trailing {
                firstFilter.append((".horizontal", leading))
            } else {
                firstFilter.append((".leading", leading))
                firstFilter.append((".trailing", trailing))
            }
            if top == bottom {
                firstFilter.append((".vertical", top))
            } else {
                firstFilter.append((".top", top))
                firstFilter.append((".bottom", bottom))
            }
        }
        var secondFilter = [(CGFloat, [String])]()
        for (tag, value) in firstFilter {
            var condition = false
            secondFilter.indices.forEach {
                if secondFilter[$0].0 == value {
                    secondFilter[$0].1.append(tag)
                    condition = true
                }
            }
            if !condition {
                secondFilter.append((value, [tag]))
            }
        }
        var lastFilter = [String]()
        for (value, tags) in secondFilter {
            var tag: String {
                if tags.count == 1 {
                    "\(tags.first!)"
                } else {
                    "[\(tags.joined(separator: ", "))]"
                }
            }
            if value != 0 {
                lastFilter.append(".padding(\(tag), \(value))")
            }
        }
        return lastFilter.joined(separator: "\n")
    }
    
    override func sideView() -> AnyView { .init(
        APPaddingSideView(padding: self)
    )}
}
