#if canImport(SwiftUI) && os(macOS)

    import SwiftUI

    @available(macOS 11.0, *)
    struct AttributedTextViewWrapper: NSViewRepresentable {
        let attributedText: NSAttributedString
        let preferredMaxLayoutWidth: CGFloat
        @Binding var height: CGFloat?

        func makeNSView(context _: Context) -> AttributedTextView {
            AttributedTextView()
        }

        func updateNSView(_ nsView: AttributedTextView, context: Context) {
            nsView.attributedText = attributedText
            nsView.preferredMaxLayoutWidth = preferredMaxLayoutWidth
            nsView.numberOfLines = context.environment.lineLimit ?? 0
            nsView.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)
            nsView.openURL = context.environment.openURL

            DispatchQueue.main.async {
                // Update the height within the current transaction
                $height
                    .transaction(context.transaction)
                    .wrappedValue = nsView.intrinsicContentSize.height
            }
        }
    }

    @available(macOS 11.0, *)
    class AttributedTextView: NSView, NSTextViewDelegate {
        var preferredMaxLayoutWidth: CGFloat = 0 {
            didSet {
                guard preferredMaxLayoutWidth != oldValue else { return }
                textView.textContainer?.containerSize = CGSize(
                    width: preferredMaxLayoutWidth,
                    height: CGFloat.infinity
                )
                invalidateIntrinsicContentSize()
            }
        }

        var attributedText: NSAttributedString {
            get { textView.attributedString() }
            set {
                textView.textStorage?.setAttributedString(newValue)
                invalidateIntrinsicContentSize()
            }
        }

        var numberOfLines: Int {
            get { textView.textContainer?.maximumNumberOfLines ?? 0 }
            set {
                textView.textContainer?.maximumNumberOfLines = newValue
                invalidateIntrinsicContentSize()
            }
        }

        var lineBreakMode: NSLineBreakMode {
            get { textView.textContainer?.lineBreakMode ?? .byWordWrapping }
            set {
                textView.textContainer?.lineBreakMode = newValue
                invalidateIntrinsicContentSize()
            }
        }

        var openURL: OpenURLAction?

        override var intrinsicContentSize: CGSize {
            if let size = cachedIntrinsicContentSize { return size }

            guard let textContainer = textView.textContainer,
                  let layoutManager = textView.layoutManager
            else {
                return textView.intrinsicContentSize
            }

            layoutManager.ensureLayout(for: textContainer)
            let size = layoutManager.usedRect(for: textContainer).size
            cachedIntrinsicContentSize = size

            return size
        }

        private let textView = NSTextView()
        private var cachedIntrinsicContentSize: CGSize?

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            setUp()
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layout() {
            super.layout()

            textView.frame = bounds
            textView.attributedString().updateImageTextAttachments(maxWidth: bounds.width)
        }

        override func invalidateIntrinsicContentSize() {
            cachedIntrinsicContentSize = nil
            super.invalidateIntrinsicContentSize()
        }

        func textView(_: NSTextView, clickedOnLink link: Any, at _: Int) -> Bool {
            guard let url = (link as? URL) ?? (link as? String).flatMap(URL.init(string:)) else {
                return false
            }

            openURL?(url)
            return false
        }

        private func setUp() {
            addSubview(textView)

            textView.drawsBackground = false
            textView.textContainerInset = .zero
            textView.isEditable = false
            textView.isRichText = false
            textView.textContainer?.lineFragmentPadding = 0
            textView.delegate = self
        }
    }

#endif
