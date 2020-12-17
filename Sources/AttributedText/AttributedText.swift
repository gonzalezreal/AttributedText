#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    public struct AttributedText: View {
        @State private var height: CGFloat?

        private let attributedText: NSAttributedString

        public init(_ attributedText: NSAttributedString) {
            self.attributedText = attributedText
        }

        public var body: some View {
            GeometryReader { proxy in
                AttributedTextViewWrapper(
                    attributedText: attributedText,
                    preferredMaxLayoutWidth: proxy.size.width,
                    height: $height
                )
            }
            .frame(height: height)
        }
    }

#endif
