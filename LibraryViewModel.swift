import Foundation

@MainActor
final class LibraryViewModel: ObservableObject {
    @Published private(set) var assets: [MediaAsset] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service = PhotoLibraryService()

    var totalBytes: Int64 {
        assets.reduce(0) { $0 + $1.byteCount }
    }

    var formattedTotalSize: String {
        ByteCountFormatter.string(fromByteCount: totalBytes, countStyle: .file)
    }

    var photoCount: Int {
        assets.filter { $0.kind == .image }.count
    }

    var videoCount: Int {
        assets.filter { $0.kind == .video }.count
    }

    var largestAssets: [MediaAsset] {
        Array(assets.sorted { $0.byteCount > $1.byteCount }.prefix(20))
    }

    func scan() async {
        isLoading = true
        errorMessage = nil

        do {
            assets = try await service.fetchAssets(limit: 200)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
