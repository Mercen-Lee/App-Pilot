import SwiftUI

class APFrame: APModifier {
    
    @Published var width: CGFloat?
    @Published var height: CGFloat?
    @Published var minWidth: CGFloat?
    @Published var maxWidth: CGFloat?
    @Published var minHeight: CGFloat?
    @Published var maxHeight: CGFloat?
    
    init() {
        super.init(type: "Frame")
    }
    
    override func combineView(_ view: AnyView) -> AnyView { .init(
        view
            .frame(width: width, height: height)
            .frame(minWidth: minWidth,
                   maxWidth: maxWidth,
                   minHeight: minHeight,
                   maxHeight: maxHeight)
    )}
    
    override var code: String {
        var result = [String]()
        var values = [(String, CGFloat)]()
        if let width {
            values.append(("width", width))
        }
        if let height {
            values.append(("height", height))
        }
        if !values.isEmpty {
            var temp = [String]()
            for (tag, value) in values {
                temp.append("\(tag): \(value)")
            }
            let final = temp.joined(separator: ", ")
            result.append(".frame(\(final))")
        }
        var minMax = [(String, CGFloat)]()
        if let minWidth {
            minMax.append(("minWidth", minWidth))
        }
        if let maxWidth {
            minMax.append(("maxWidth", maxWidth))
        }
        if let minHeight {
            minMax.append(("minHeight", minHeight))
        }
        if let maxHeight {
            minMax.append(("maxHeight", maxHeight))
        }
        if !minMax.isEmpty {
            var temp = [String]()
            for (tag, value) in minMax {
                temp.append("\(tag): \(value)")
            }
            let final = temp.joined(separator: ", ")
            result.append(".frame(\(final))")
        }
        return result.joined(separator: "\n")
    }
    
    override func sideView() -> AnyView { .init(
        APFrameSideView(frame: self)
    )}
}
