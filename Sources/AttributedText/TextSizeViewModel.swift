#if !os(watchOS)
    import SwiftUI

    final class TextSizeViewModel: ObservableObject {
        @Published var textSize: CGSize?

        func didUpdateTextView(_ textView: AttributedTextImpl.TextView) {
            textSize = textView.intrinsicContentSize
        }
    }
#endif
