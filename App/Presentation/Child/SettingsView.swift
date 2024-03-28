import SwiftUI
import PhotosUI

struct SettingsView: View {
    
    @EnvironmentObject var state: RootState
    @State var iconSelection: PhotosPickerItem?

    var body: some View {
        VStack(spacing: 0) {
            Group {
                if let appIcon = state.app.appIcon {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: appIcon)
                            .resizable()
                        Button {
                            state.app.appIcon = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundStyle(Color.white,
                                                 Color.black.opacity(0.5))
                                .frame(width: 30, height: 30)
                        }
                        .padding(15)
                    }
                } else {
                    PhotosPicker(selection: $iconSelection,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        ZStack {
                            Image("Package")
                                .resizable()
                            Color.black.opacity(0.5)
                            Text("Select\nCustom Icon")
                                .foregroundStyle(Color.white)
                                .font(.title3)
                        }
                    }
                }
            }
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 29))
            .padding(.bottom, 20)
            TitledView("App Name") {
                Cell {
                    TextField("Name", text: $state.app.name)
                        .dismissButton()
                }
            }
            TitledView("Initial View") {
                Menu {
                    ForEach(state.app.screens.indices, id: \.self) { idx in
                        let content = state.app.screens[idx]
                        Button(content.name) {
                            state.app.defaultScreen = content
                        }
                    }
                } label: {
                    Cell {
                        HStack(spacing: 12) {
                            Text(state.app.defaultScreen.name)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 36)
        .padding(.horizontal, 12)
        .frame(minWidth: 500)
        .background(Color.fill.ignoresSafeArea())
        .onChange(of: iconSelection) { newValue in
            if let newValue {
                newValue.loadTransferable(type: Data.self) { result in
                    DispatchQueue.main.async {
                        guard iconSelection == self.iconSelection else { return }
                        if case let .success(image) = result {
                            state.app.appIcon = UIImage(data: image!)
                            iconSelection = nil
                        }
                    }
                }
            }
        }
    }
}
