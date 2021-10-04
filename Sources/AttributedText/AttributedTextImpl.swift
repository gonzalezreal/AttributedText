#if !os(watchOS)
    import SwiftUI

    struct AttributedTextImpl {
        var attributedText: NSAttributedString
        var maxLayoutWidth: CGFloat
        var textSizeViewModel: TextSizeViewModel
        var openLink: ((URL) -> Void)?
    }
#endif
