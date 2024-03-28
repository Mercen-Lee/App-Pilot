import SwiftUI

final class APApp: APObject {
    
    @Published var name: String
    @Published var screens: [APScreen]
    @Published var assets: [APAsset]
    @Published var defaultScreen: APScreen
    @Published var accentColor: Color?
    @Published var appIcon: UIImage?
    
    let fileManager: FileManager = .default
    
    init(name: String, screens: [APScreen], assets: [APAsset]) {
        self.name = name
        self.screens = screens
        self.assets = assets
        self.defaultScreen = screens[0]
        super.init(type: "App")
    }
    
    var getIcon: UIImage {
        appIcon ?? .init(named: "Package")!
    }
}
