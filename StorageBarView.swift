import SwiftUI

struct StorageBarView: View {
    let photos: Int64
    let videos: Int64

    private var total: Int64 { max(photos + videos, 1) }
    private var photoShare: Double { Double(photos) / Double(total) }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GeometryReader { proxy in
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.blue)
                        .frame(width: proxy.size.width * photoShare)
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.purple)
                }
            }
            .frame(height: 14)

            HStack {
                Label("Photos", systemImage: "photo")
                Spacer()
                Label("Videos", systemImage: "video")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}
