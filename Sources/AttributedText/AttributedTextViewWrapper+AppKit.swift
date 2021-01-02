#if canImport(SwiftUI) && os(macOS)

    import SwiftUI

    @available(macOS 11.0, *)
    struct AttributedTextViewWrapper: NSViewRepresentable {
        let attributedText: NSAttributedString
        let store: AttributedTextStore

        func makeNSView(context _: Context) -> AttributedTextView {
            let nsView = AttributedTextView()
            store.attributedTextView = nsView

            return nsView
        }

        func updateNSView(_ nsView: AttributedTextView, context: Context) {
            nsView.attributedText = attributedText
            nsView.numberOfLines = context.environment.lineLimit ?? 0
            nsView.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)
            nsView.openURL = context.environment.openURL

            store.onUpdateView()
        }
    }

#endif
