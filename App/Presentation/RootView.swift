import SwiftUI

struct RootView: View {
    
    @StateObject var state = RootState()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView()
                .environmentObject(state)
            Stripe(.horizontal)
                .ignoresSafeArea()
            GeometryReader { outsideProxy in
                HStack(spacing: 0) {
                    if state.isDeviceHorizontal {
                        HierarchyView()
                            .environmentObject(state)
                        Stripe(.vertical)
                            .ignoresSafeArea()
                        if state.newViewPresented {
                            NewViewView()
                                .environmentObject(state)
                            Stripe(.vertical)
                                .ignoresSafeArea()
                        }
                    }
                    if state.mode == .code {
                        CodeView(size: outsideProxy.size)
                            .environmentObject(state)
                    } else {
                        Spacer()
                        Group {
                            if state.mode == .draft {
                                DraftView()
                                    .aspectRatio(9/16, contentMode: .fit)
                            } else {
                                PreviewView()
                            }
                        }
                        .environmentObject(state)
                        .padding(.top, outsideProxy.safeAreaInsets.bottom)
                        .padding(.vertical, 20)
                        Spacer()
                    }
                    if state.isDeviceHorizontal {
                        Stripe(.vertical)
                            .ignoresSafeArea()
                        VStack(spacing: 0) {
                            let isNone = state.selectedComponent as? APNone != nil
                            HStack {
                                let selected = state.selectedComponent
                                if let variable = selected as? APVariable {
                                    Text("\(variable.type)")
                                        .opacity(0.5)
                                    Text("\(variable.name)")
                                } else if let view = selected as? APView {
                                    Text(view.displayName)
                                } else if let asset = selected as? APAsset {
                                    Text(asset.name)
                                } else {
                                    Text(state.selectedScreen.name)
                                }
                                Spacer()
                                if (!isNone
                                    || state.app.screens.count != 1
                                    || state.app.defaultScreen != state.selectedScreen)
                                    && state.selectedComponent != state.selectedScreen.body {
                                    Button {
                                        state.componentToDelete = {
                                            if isNone {
                                                state.selectedScreen
                                            } else {
                                                state.selectedComponent
                                            }
                                        }()
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundStyle(Color.label)
                                    }
                                    .padding(.vertical, -5)
                                }
                            }
                            .fontWeight(.bold)
                            .padding(12)
                            Stripe(.horizontal)
                            GeometryReader { insideProxy in
                                ScrollView(showsIndicators: false) {
                                    state.selectedComponent.sideView()
                                        .environmentObject(state.selectedScreen)
                                        .environmentObject(state.app)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: isNone ? insideProxy.size.height : nil)
                                }
                            }
                        }
                        .frame(width: 300)
                        .background(Color.fill.ignoresSafeArea())
                    }
                }
                .onChange(of: outsideProxy.size) { newValue in
                    state.refreshOrientation(newValue)
                }
                .onAppear {
                    state.refreshOrientation(outsideProxy.size)
                }
            }
            .ignoresSafeArea(.keyboard)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
        .overlay(
            Group {
                if state.warningPresented {
                    VStack(spacing: 50) {
                        Image(systemName: "rectangle.portrait.rotate")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Text("Turn your device horizontally")
                            .font(.largeTitle)
                    }
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5).ignoresSafeArea())
                } else {
                    EmptyView()
                }
            }
        )
        .alert("Are you sure you want to delete \(state.nameOfComponentToDelete)?",
               isPresented: Binding(get: {
            state.componentToDelete != nil
        }, set: {
            if !$0 {
                state.componentToDelete = nil
            }
        })) {
            Button("Delete", role: .destructive) {
                state.deleteComponent()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("It cannot be undone.")
        }
    }
}
