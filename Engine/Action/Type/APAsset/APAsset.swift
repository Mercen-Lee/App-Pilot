import SwiftUI

class APAsset: APObject {
    
    @Published var name: String
    let image: UIImage
    
    init(_ name: String, image: UIImage) {
        self.name = name
        self.image = image
        super.init(type: "Image Asset")
    }
    
    override func sideView() -> AnyView { .init(
        APAssetSideView(asset: self)
    )}
}
