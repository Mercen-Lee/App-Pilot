import UIKit

extension APApp {
    
    func clearTempDirectory() {
        let tmpDirectory = try? fileManager
            .contentsOfDirectory(atPath: NSTemporaryDirectory())
        try? tmpDirectory?.forEach { [unowned self] file in
            let path = String(format: "%@%@", NSTemporaryDirectory(), file)
            try fileManager.removeItem(atPath: path)
        }
    }
    
    func getTempDirectoryURL() -> URL {
        NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
    }
    
    func getDirectory(_ path: String) -> String {
        return getTempDirectoryURL()
            .appendingPathComponent("\(name).swiftpm")
            .appendingPathComponent(path)
            .path
    }
    
    func createDirectory(_ path: String) {
        let directory = getDirectory(path)
        try? fileManager.createDirectory(atPath: directory,
                                         withIntermediateDirectories: true,
                                         attributes: nil)
    }
    
    func createTextFile(_ path: String, body: String) {
        let directory = getDirectory(path)
        try? body.write(toFile: directory, atomically: true, encoding: .utf8)
    }
    
    func createAsset(_ asset: APAsset) {
        let contentsJson = Constants.getContentsJson(asset.name)
        let directory = "Assets.xcassets/\(asset.name).imageset"
        createDirectory(directory)
        createTextFile("\(directory)/Contents.json", body: contentsJson)
        if let data = asset.image.pngData() {
            let assetPath = getTempDirectoryURL()
                .appendingPathComponent("\(name).swiftpm")
                .appendingPathComponent("Assets.xcassets")
                .appendingPathComponent("\(asset.name).imageset")
                .appendingPathComponent("\(asset.name).png")
            try? data.write(to: assetPath, options: [.atomic])
        }
    }
    
    func createAssets() {
        let contentsJson = """
                           {
                             "info" : {
                                 "author" : "xcode",
                                 "version" : 1
                             }
                           }
                           """
        createTextFile("Assets.xcassets/Contents.json", body: contentsJson)
        assets.forEach {
            createAsset($0)
        }
    }
    
    func createAppIcon() {
        let aspectFillSize = CGSize(width: 512, height: 512)
        let scaleFactor = max(aspectFillSize.width / getIcon.size.width,
                              aspectFillSize.height / getIcon.size.height)
        var result = CGRect.zero
        result.size.width = getIcon.size.width * scaleFactor
        result.size.height = getIcon.size.height * scaleFactor
        result.origin.x = (aspectFillSize.width - result.size.width) / 2.0
        result.origin.y = (aspectFillSize.height - result.size.height) / 2.0
        UIGraphicsBeginImageContextWithOptions(aspectFillSize, false, 0.0)
        getIcon.draw(in: result)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let directory = "Assets.xcassets/AppIcon.appiconset"
        createDirectory(directory)
        createTextFile("\(directory)/Contents.json", body: Constants.appIconContents)
        if let data = scaledImage!.pngData() {
            let assetPath = getTempDirectoryURL()
                .appendingPathComponent("\(name).swiftpm")
                .appendingPathComponent("Assets.xcassets")
                .appendingPathComponent("AppIcon.appiconset")
                .appendingPathComponent("AppIcon.png")
            try? data.write(to: assetPath, options: [.atomic])
        }
    }
    
    func createConfiguration() {
        createTextFile("Package.swift", body: Constants.getPackageSwift(name))
        createTextFile("MyApp.swift", body: Constants.getAppSwift(defaultScreen.name))
        createTextFile("Color.swift", body: Constants.colorSwift)
    }
    
    func createView() {
        screens.forEach {
            createTextFile("\($0.name).swift", body: $0.code)
        }
    }
    
    func createApp() {
        clearTempDirectory()
        createDirectory("")
        createDirectory("Assets.xcassets")
        createAssets()
        createAppIcon()
        createConfiguration()
        createView()
    }
    
    func shareUrl() -> URL {
        createApp()
        var result: URL!
        let fileName = "\(name).swiftpm"
        let directory = getTempDirectoryURL().appendingPathComponent(fileName)
        NSFileCoordinator()
            .coordinate(readingItemAt: directory, options: [.forUploading], error: nil) {
                let url = try! fileManager.url(
                    for: .itemReplacementDirectory,
                    in: .userDomainMask,
                    appropriateFor: $0,
                    create: true
                ).appendingPathComponent("\(fileName).zip")
                try! fileManager.moveItem(at: $0, to: url)
                result = url
            }
        return result
    }
}
