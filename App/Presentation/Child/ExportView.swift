import SwiftUI

struct ExportView: UIViewControllerRepresentable {
    
    @EnvironmentObject var state: RootState
    @Environment(\.dismiss) var dismiss
    
    typealias Context = UIViewControllerRepresentableContext<ExportView>
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(
            activityItems: [state.app.shareUrl()],
            applicationActivities: nil
        )
        vc.completionWithItemsHandler = { _, _, _, _ in
            self.dismiss()
        }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: Context) { }
}
