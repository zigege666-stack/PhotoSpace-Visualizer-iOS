import Foundation
import Photos

enum PhotoLibraryError: LocalizedError {
    case accessDenied

    var errorDescription: String? {
        "Photo library access was not granted."
    }
}

final class PhotoLibraryService {
    private let resourceManager = PHAssetResourceManager.default()

    func requestAccess() async -> Bool {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        return status == .authorized || status == .limited
    }

    func fetchAssets(limit: Int = 200) async throws -> [MediaAsset] {
        guard await requestAccess() else {
            throw PhotoLibraryError.accessDenied
        }

        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        options.fetchLimit = max(1, limit)

        let result = PHAsset.fetchAssets(with: options)
        var output: [MediaAsset] = []

        for index in 0..<result.count {
            let asset = result.object(at: index)
            let size = await byteCount(for: asset)
            output.append(MediaAsset(asset: asset, byteCount: size))
        }

        return output
    }

    private func byteCount(for asset: PHAsset) async -> Int64 {
        var total: Int64 = 0
        for resource in PHAssetResource.assetResources(for: asset) {
            total += await byteCount(for: resource)
        }
        return total
    }

    private func byteCount(for resource: PHAssetResource) async -> Int64 {
        await withCheckedContinuation { continuation in
            let options = PHAssetResourceRequestOptions()
            options.isNetworkAccessAllowed = true

            var count: Int64 = 0
            resourceManager.requestData(
                for: resource,
                options: options,
                dataReceivedHandler: { data in
                    count += Int64(data.count)
                },
                completionHandler: { error in
                    continuation.resume(returning: error == nil ? count : 0)
                }
            )
        }
    }
}
