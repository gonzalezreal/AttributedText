#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    public struct AttributedText: View {

        #if os(macOS)
        /// Handles the click on the link.
        ///
        /// - Parameters:
        ///     - link: The link that was clicked.
        /// - Returns: `true` if the click was handled; otherwise, `false` to allow the next responder to handle it.
        public typealias OpenURLAction = (_ link: URL) -> Bool
        #else
        /// Handles interaction with the specified URL.
        ///
        /// You can return `true` from this closure to allow the system to perform default actions
        /// such as opening URL in user's browser or presenting list of actions. If you return `false`
        /// no additional actions will be performed.
        ///
        /// - Parameters:
        ///     - URL: The URL to be processed.
        ///     - interaction: The type of interaction that is occurring.
        /// - Returns: `true` if interaction with the URL should be allowed; `false` if interaction should not be allowed.
        public typealias OpenURLAction = (_ URL: URL, _ interaction: UITextItemInteraction) -> Bool
        #endif

        @StateObject private var textViewStore = TextViewStore()

        private let attributedText: NSAttributedString
        private let openURL: OpenURLAction?

        public init(_ attributedText: NSAttributedString, openURL: OpenURLAction? = nil) {
            self.attributedText = attributedText
            self.openURL = openURL
        }

        public var body: some View {
            GeometryReader { geometry in
                TextViewWrapper(
                    attributedText: attributedText,
                    maxLayoutWidth: geometry.maxWidth,
                    textViewStore: textViewStore,
                    openURL: openURL
                )
            }
            .frame(
                idealWidth: textViewStore.intrinsicContentSize?.width,
                idealHeight: textViewStore.intrinsicContentSize?.height
            )
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    private extension GeometryProxy {
        var maxWidth: CGFloat {
            size.width - safeAreaInsets.leading - safeAreaInsets.trailing
        }
    }

#endif
