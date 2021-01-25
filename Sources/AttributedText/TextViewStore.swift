#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    final class TextViewStore: ObservableObject {
        @Published var intrinsicContentSize: CGSize?

        func didUpdateTextView(_ textView: TextViewWrapper.View) {
            intrinsicContentSize = textView.intrinsicContentSize
        }
    }

#endif
