# AI Collaboration Notes

## Project objective
Build an iOS prototype that helps users understand which photos and videos are consuming the most storage space.

## Tools used
### ChatGPT
Used for product problem clarification, MVP definition, task decomposition, architecture discussion, edge cases, debugging strategies and review.

### Codex
Used for Swift / SwiftUI implementation assistance, repetitive boilerplate, refactoring, compiler-error explanation and iteration.

## Division of work
### Human responsibilities
I was responsible for identifying the pain point, deciding the MVP scope, designing the user flow, splitting the work into modules, validating generated code, checking API choices, testing behaviour and deciding which implementation to keep.

### AI responsibilities
AI assisted with drafting code, explaining unfamiliar frameworks, proposing alternative approaches, speeding up debugging and improving documentation.

## Key challenge
PhotoKit does not provide a simple universal file-size property on `PHAsset`. The prototype therefore uses `PHAssetResourceManager` to stream asset-resource data and count bytes asynchronously.

Because this is more expensive than ordinary metadata access, the MVP intentionally limits the number of assets scanned. A production version would add caching, cancellation and incremental scanning.

## Workflow
1. Define the user problem.
2. Translate it into testable requirements.
3. Break the implementation into permission, asset discovery, size calculation, sorting and UI.
4. Ask AI to help with one module at a time.
5. Review generated code.
6. Test behaviour and compiler feedback.
7. Revise requirements when needed.
8. Integrate only validated modules.

## What I learned
AI worked best when I defined constraints and verified outputs. Smaller prompts with explicit acceptance criteria were more reliable than asking for an entire app in one step.
