import CoreTransferable

struct APSwiftPackage: Transferable {
    
    let url: () async -> URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .zip) {
            SentTransferredFile(await $0.url())
        }
    }
}
