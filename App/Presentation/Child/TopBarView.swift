import SwiftUI

struct TopBarView: View {
    
    @EnvironmentObject var state: RootState
    
    @State var newScreenPresented: Bool = false
    @State var exportPresented: Bool = false
    @State var settingsPresented: Bool = false
    @State var warningPresented: Bool = false
    
    var body: some View {
        ZStack {
            if state.isDeviceHorizontal {
                HStack {
                    Image(systemName: "app.badge.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color.accent, Color.label)
                        .padding(.leading, 15)
                        .padding(.trailing, 10)
                    Menu {
                        ForEach(state.app.screens.indices, id: \.self) { idx in
                            let content = state.app.screens[idx]
                            Button(content.name) {
                                if state.selectedScreen.id != content.id {
                                    state.selectedComponent = APNone()
                                    state.selectedScreen = content
                                }
                            }
                        }
                        Button {
                            newScreenPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.accent)
                    } label: {
                        Cell(removePadding: true) {
                            HStack(spacing: 12) {
                                Text(state.selectedScreen.name)
                                    .font(.title)
                                Image(systemName: "chevron.down")
                                    .font(.title2)
                            }
                            .padding(.vertical, 7)
                            .padding(.horizontal, 20)
                        }
                    }
                    .popover(isPresented: $newScreenPresented) {
                        NewScreenView()
                            .environmentObject(state)
                    }
                    Spacer()
                    Button {
                        exportPresented.toggle()
                    } label: {
                        Cell {
                            HStack(spacing: 8) {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .font(.callout)
                                Text("Export")
                            }
                        }
                    }
                    .popover(isPresented: $exportPresented) {
                        ExportView()
                            .environmentObject(state)
                    }
                    Button {
                        settingsPresented.toggle()
                    } label: {
                        Cell {
                            HStack(spacing: 8) {
                                Image(systemName: "gearshape.fill")
                                Text("Settings")
                            }
                        }
                    }
                    .popover(isPresented: $settingsPresented) {
                        SettingsView()
                            .environmentObject(state)
                    }
                }
                .padding(.horizontal, 5)
            } else {
                Button {
                    warningPresented.toggle()
                } label: {
                    Cell {
                        Image(systemName: "exclamationmark.triangle.fill")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 5)
            }
            HStack {
                ForEach(ViewStyle.allCases, id: \.self) { type in
                    type.makeCell(state: $state.mode)
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color.fill)
        .alert("Excuse me!", isPresented: $warningPresented) {
            Button("OK") { }
        } message: {
            Text("Please turn your device horizontally.")
        }
    }
}
