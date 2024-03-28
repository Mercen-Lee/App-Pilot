import SwiftUI

final class APImage: APView {
    
    @Published var asset: APAsset?
    @Published var mode: APImageMode = .fit
    
    init(_ asset: APAsset? = nil) {
        self.asset = asset
        super.init(type: "Image")
    }
    
    override func body(draft: Bool = false,
                       selected: Binding<APObject>? = nil) -> AnyView {
        .init(draft, view: self, selected: selected) { [self] in
            if let asset {
                if let value = mode.value {
                    Image(uiImage: asset.image)
                        .resizable()
                        .aspectRatio(contentMode: value)
                } else {
                    Image(uiImage: asset.image)
                        .resizable()
                }
            }
        }
    }
    
    override func sideView() -> AnyView {
        .init(modifier: modifier) {
            APImageSideView(image: self)
        }
    }
    
    override var code: String {
        .init(view: self) {
            if let asset {
                var result = ["Image(\"\(asset.name)\")\n.resizable()"]
                if mode != .default {
                    result.append(".aspectRatio(contentMode: .\(mode.rawValue))")
                }
                return result.joined(separator: "\n")
            } else { return .init() }
        }
    }
}
