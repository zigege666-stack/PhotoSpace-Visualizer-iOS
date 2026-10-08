import Foundation
import Photos

struct MediaAsset: Identifiable, Hashable {
    enum Kind: String {
        case image = "Photo"
        case video = "Video"
        case other = "Other"
    }

    let id: String
    let kind: Kind
    let creationDate: Date?
    let byteCount: Int64

    var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: byteCount, countStyle: .file)
    }

    init(asset: PHAsset, byteCount: Int64) {
        id = asset.localIdentifier
        creationDate = asset.creationDate
        self.byteCount = byteCount

        switch asset.mediaType {
        case .image: kind = .image
        case .video: kind = .video
        default: kind = .other
        }
    }
}
