#if canImport(SwiftUI) && canImport(UIKit) && !os(watchOS)

    import SwiftUI

    @available(iOS 14.0, tvOS 14.0, *)
    struct AttributedTextViewWrapper: UIViewRepresentable {
        let attributedText: NSAttributedString
        let store: AttributedTextStore

        func makeUIView(context _: Context) -> AttributedTextView {
            let uiView = AttributedTextView()
            store.attributedTextView = uiView

            return uiView
        }

        func updateUIView(_ uiView: AttributedTextView, context: Context) {
            uiView.attributedText = attributedText
            uiView.numberOfLines = context.environment.lineLimit ?? 0
            uiView.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)
            uiView.openURL = context.environment.openURL

            store.onUpdateView()
        }
    }

#endif
