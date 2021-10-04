#if !os(watchOS)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
    struct AttributedTextImpl {
        var attributedText: NSAttributedString
        var maxLayoutWidth: CGFloat
        var textSizeViewModel: TextSizeViewModel
        var openLink: ((URL) -> Void)?
    }

#endif
