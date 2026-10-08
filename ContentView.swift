import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LibraryViewModel()

    private var photoBytes: Int64 {
        viewModel.assets.filter { $0.kind == .image }.reduce(0) { $0 + $1.byteCount }
    }

    private var videoBytes: Int64 {
        viewModel.assets.filter { $0.kind == .video }.reduce(0) { $0 + $1.byteCount }
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Storage overview") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.formattedTotalSize)
                            .font(.system(size: 34, weight: .bold, design: .rounded))

                        Text("Scanned \(viewModel.assets.count) recent items")
                            .foregroundStyle(.secondary)

                        StorageBarView(photos: photoBytes, videos: videoBytes)

                        HStack {
                            stat(title: "Photos", value: "\(viewModel.photoCount)")
                            Spacer()
                            stat(title: "Videos", value: "\(viewModel.videoCount)")
                        }
                    }
                    .padding(.vertical, 8)
                }

                if let error = viewModel.errorMessage {
                    Section {
                        Text(error).foregroundStyle(.red)
                    }
                }

                Section("Largest items") {
                    if viewModel.isLoading {
                        ProgressView("Scanning…")
                    } else if viewModel.largestAssets.isEmpty {
                        ContentUnavailableView(
                            "No scan results",
                            systemImage: "photo.on.rectangle",
                            description: Text("Tap Scan Library to analyse recent photos and videos.")
                        )
                    } else {
                        ForEach(viewModel.largestAssets) { asset in
                            HStack {
                                Image(systemName: asset.kind == .video ? "video.fill" : "photo.fill")
                                    .frame(width: 28)

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(asset.kind.rawValue).font(.headline)
                                    if let date = asset.creationDate {
                                        Text(date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }

                                Spacer()
                                Text(asset.formattedSize).font(.subheadline.monospacedDigit())
                            }
                        }
                    }
                }
            }
            .navigationTitle("PhotoSpace")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(viewModel.isLoading ? "Scanning…" : "Scan Library") {
                        Task { await viewModel.scan() }
                    }
                    .disabled(viewModel.isLoading)
                }
            }
        }
    }

    private func stat(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value).font(.title3.bold())
            Text(title).font(.caption).foregroundStyle(.secondary)
        }
    }
}
