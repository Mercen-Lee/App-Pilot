import SwiftUI
import PhotosUI

struct NewAssetView: View {
    
    @EnvironmentObject var state: RootState
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isFocused: Bool
    @State var name: String = ""
    @State var imageSelection: PhotosPickerItem?
    @State var selectedImage: UIImage?
    @State var alert: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitledView("Identifier") {
                Cell {
                    TextField("NewImage", text: $name)
                        .focused($isFocused)
                        .dismissButton()
                        .textInputAutocapitalization(.never)
                }
            }
            TitledView("Image Selection") {
                PhotosPicker(selection: $imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Group {
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            VStack {
                                Image(systemName: "photo.badge.plus")
                                    .imageScale(.large)
                                Text("Select Image")
                            }
                            .foregroundStyle(Color.label)
                        }
                    }
                    .frame(width: 500, height: 300)
                    .background(Color.cell)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Spacer()
            LargeButton("Create a new Image Asset") {
                if name.isEmpty {
                    alert = "Identifier is empty. Let's fill the blank."
                } else if state.app.assets.map({ $0.name }).contains(name) {
                    alert = "It's a duplicate identifier."
                } else if let selectedImage {
                    let asset = APAsset(name, image: selectedImage)
                    state.createNewAsset(asset)
                    dismiss()
                } else {
                    alert = "Please select an Image."
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.vertical, 36)
        .padding(.horizontal, 12)
        .frame(minWidth: 500)
        .background(Color.fill.ignoresSafeArea())
        .onChange(of: imageSelection) { newValue in
            if let newValue {
                newValue.loadTransferable(type: Data.self) { result in
                    DispatchQueue.main.async {
                        guard imageSelection == self.imageSelection else { return }
                        if case let .success(image) = result {
                            selectedImage = UIImage(data: image!)
                            imageSelection = nil
                        }
                    }
                }
            }
        }
        .alert("Wait!", isPresented: Binding(get: { alert != nil },
                                             set: { if !$0 { alert = nil } })) {
            Button("OK") { }
        } message: {
            Text("\(alert ?? "")")
        }
        .onAppear {
            isFocused = true
        }
    }
}
