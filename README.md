# PhotoSpace Visualizer

AI-assisted iOS photo storage visualisation prototype built with SwiftUI and PhotoKit.

## Why I built this
The native iOS Photos app makes it easy to browse media, but it is not designed to answer a simple storage question: **which photos and videos are taking the most space?**

PhotoSpace Visualizer explores a lightweight way to scan a user's photo library, estimate storage usage, rank large items, and present the result in a simple visual interface.

## Current MVP
- Request photo-library permission with PhotoKit
- Load image and video assets
- Read resource sizes asynchronously
- Rank media by storage usage
- Show total scanned size and media counts
- Display the largest items in a SwiftUI list

> This repository is an MVP / portfolio prototype, not an App Store release.

## Tech stack
- Swift
- SwiftUI
- PhotoKit
- Swift Concurrency

## Human–AI collaboration
I used **ChatGPT** for product definition, requirement decomposition, architecture discussion, debugging ideas and review. I used **Codex** to assist with Swift / SwiftUI implementation, refactoring and error fixing.

My role was to identify the user problem, define the MVP, break the project into modules, evaluate AI-generated solutions, test outputs and decide what to keep in the final prototype.

More detail: [docs/AI-Collaboration.md](docs/AI-Collaboration.md)

## Core challenge
PhotoKit does not expose one simple, cheap `fileSize` property for every `PHAsset`. The MVP therefore retrieves `PHAssetResource` data asynchronously and counts streamed bytes. The scan is intentionally bounded so the prototype demonstrates the workflow without trying to process an unlimited library at once.

## Run locally
1. Open Xcode.
2. Create a new **iOS App** project named `PhotoSpaceVisualizer` using SwiftUI.
3. Add the Swift files from this repository to the project.
4. Add **Privacy - Photo Library Usage Description** to the app target's Info settings.
5. Run on a physical iPhone or simulator containing sample photos.

## Privacy
The prototype analyses the user's local photo library only. It does not upload photos or videos to a server.

## Next steps
- Add thumbnail previews
- Add category filtering for images and videos
- Add duplicate / similar-item detection
- Improve scan progress and cancellation
- Cache previously calculated sizes
- Test performance on larger libraries

## Portfolio note
This project demonstrates: **problem discovery → requirement definition → AI-assisted implementation → human validation → iteration**.
