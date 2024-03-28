import SwiftUI
import Combine

class RootState: ObservableObject {
    
    @Published var isDeviceHorizontal: Bool = true
    @Published var warningPresented: Bool = false
    @Published var previewPresented: Bool = false
    @Published var componentToDelete: APObject?
    @Published var mode: ViewStyle = .draft
    @Published var newViewPresented: Bool = false
    @Published var draggedView: APView?
    
    @Published var app: APApp {
        didSet { subscribeToApp() }
    }
    @Published var selectedComponent: APObject = APNone() {
        didSet { subscribeToSelectedComponent() }
    }
    @Published var selectedScreen: APScreen {
        didSet { subscribeToSelectedScreen() }
    }
    
    var appSubscription: AnyCancellable?
    var selectedComponentSubscription: AnyCancellable?
    var selectedScreenSubscription: AnyCancellable?
    
    init() {
        let asset = APAsset("ApplePark",
                            image: .init(named: "ApplePark")!)
        let contentView = APScreen("ContentView",
                                   state: [APInt("integer", value: 1),
                                           APFloat("float", value: 1.1),
                                           APString("string", value: "Hello, world!"),
                                           APBool("boolean", value: false)],
                                   body: APVStack(spacing: 20) {
            APImage(asset)
            APVStack(alignment: .leading) {
                APText(.default("Apple Park"))
                    .font(30, weight: .bold)
                APText(.default("1 Apple Park Way Cupertino, CA 95014"))
                    .font(10, weight: .light)
                    .foregroundColor(Color.gray)
                    .padding(bottom: 10)
                APText(.default("""
                                Apple Park is an Apple Campus in Cupertino, \
                                which was completed in 2017. \
                                The largest curved glass-covered \
                                sides in the world are circular, \
                                shaped like donuts. Recently, \
                                WWDC and Apple Events took place here.
                                """))
            }
            .padding(leading: 20, trailing: 20)
            APSpacer()
        })
        app = APApp(name: "PilotApp",
                    screens: [contentView],
                    assets: [asset])
        selectedScreen = contentView
        subscribeToApp()
        subscribeToSelectedComponent()
        subscribeToSelectedScreen()
    }
    
    deinit {
        appSubscription?.cancel()
        selectedComponentSubscription?.cancel()
        selectedScreenSubscription?.cancel()
    }
    
    func subscribeToApp() {
        appSubscription = app.objectWillChange
            .sink(receiveValue: objectWillChange.send)
    }
    
    func subscribeToSelectedComponent() {
        selectedComponentSubscription = selectedComponent.objectWillChange
            .sink(receiveValue: objectWillChange.send)
    }
    
    func subscribeToSelectedScreen() {
        selectedScreenSubscription = selectedScreen.objectWillChange
            .sink(receiveValue: objectWillChange.send)
    }
    
    func updateView() {
        objectWillChange.send()
    }
    
    var nameOfComponentToDelete: String {
        if let variable = componentToDelete as? APVariable {
            variable.name
        } else if let view = componentToDelete as? APView {
            "this \(view.displayName)"
        } else if let screen = componentToDelete as? APScreen {
            screen.name
        } else if let asset = componentToDelete as? APAsset {
            asset.name
        } else {
            componentToDelete?.type ?? ""
        }
    }
    
    func refreshOrientation(_ size: CGSize) {
        isDeviceHorizontal = size.width > size.height
        if !isDeviceHorizontal {
            warningPresented = true
            withAnimation(.default.delay(1)) {
                warningPresented = false
            }
        }
    }
    
    func createNewView(_ name: String) {
        let newScreen = APScreen(name,
                                 state: [],
                                 body: APVStack {
            APText(.default("Hello, world!"))
        })
        app.screens.append(newScreen)
        selectedScreen = newScreen
    }
    
    func createNewState(_ variable: APVariable) {
        selectedScreen.state.append(variable)
        selectedComponent = variable
    }
    
    func createNewAsset(_ asset: APAsset) {
        app.assets.append(asset)
        selectedComponent = asset
    }
    
    func searchRoot(_ view: APView,
                    stack: APStack,
                    completion: @escaping (APStack) -> Void) {
        if stack.items.contains(view) {
            completion(stack)
        } else {
            stack.items.forEach {
                if let childStack = $0 as? APStack {
                    searchRoot(view,
                               stack: childStack,
                               completion: completion)
                }
            }
        }
    }
    
    func deleteComponent() {
        if let variable = componentToDelete as? APVariable {
            selectedScreen.state.remove(variable)
        } else if let view = componentToDelete as? APView {
            if let stack = selectedScreen.body as? APStack {
                searchRoot(view, stack: stack) { foundStack in
                    foundStack.items.remove(view)
                }
            }
        } else if let screen = componentToDelete as? APScreen {
            app.screens.remove(screen)
            selectedScreen = app.defaultScreen
        } else if let asset = componentToDelete as? APAsset {
            app.assets.remove(asset)
        }
        componentToDelete = nil
        selectedComponent = APNone()
    }
}
