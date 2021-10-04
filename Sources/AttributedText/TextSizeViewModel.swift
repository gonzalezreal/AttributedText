#if !os(watchOS)
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
    final class TextSizeViewModel: ObservableObject {
        @Published var textSize: CGSize?

        func didUpdateTextView(_ textView: AttributedTextImpl.TextView) {
            textSize = textView.intrinsicContentSize
        }
    }

#endif
