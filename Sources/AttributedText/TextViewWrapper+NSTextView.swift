#if canImport(SwiftUI) && os(macOS)

    import SwiftUI

    @available(macOS 11.0, *)
    struct TextViewWrapper: NSViewRepresentable {
        final class View: NSTextView {
            var maxLayoutWidth: CGFloat {
                get { textContainer?.containerSize.width ?? 0 }
                set {
                    guard textContainer?.containerSize.width != newValue else { return }
                    textContainer?.containerSize.width = newValue
                    invalidateIntrinsicContentSize()
                }
            }

            override var intrinsicContentSize: NSSize {
                guard maxLayoutWidth > 0,
                      let textContainer = self.textContainer,
                      let layoutManager = self.layoutManager
                else {
                    return super.intrinsicContentSize
                }

                layoutManager.ensureLayout(for: textContainer)
                return layoutManager.usedRect(for: textContainer).size
            }
        }

        final class Coordinator: NSObject, NSTextViewDelegate {
            var openURL: OpenURLAction?
            var customOpenURL: AttributedText.OpenURLAction?

            func textView(_: NSTextView, clickedOnLink link: Any, at _: Int) -> Bool {
                guard let url = (link as? URL) ?? (link as? String).flatMap(URL.init(string:)) else {
                    return false
                }

                if let customOpenURL = customOpenURL {
                    return customOpenURL(url)
                }
                openURL?(url)
                return false
            }
        }

        let attributedText: NSAttributedString
        let maxLayoutWidth: CGFloat
        let textViewStore: TextViewStore
        let openURL: AttributedText.OpenURLAction?

        func makeNSView(context: Context) -> View {
            let nsView = View(frame: .zero)

            nsView.drawsBackground = false
            nsView.textContainerInset = .zero
            nsView.isEditable = false
            nsView.isRichText = false
            nsView.textContainer?.lineFragmentPadding = 0
            // we are setting the container's width manually
            nsView.textContainer?.widthTracksTextView = false
            nsView.delegate = context.coordinator

            return nsView
        }

        func updateNSView(_ nsView: View, context: Context) {
            nsView.textStorage?.setAttributedString(attributedText)
            nsView.maxLayoutWidth = maxLayoutWidth

            nsView.textContainer?.maximumNumberOfLines = context.environment.lineLimit ?? 0
            nsView.textContainer?.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)

            context.coordinator.openURL = context.environment.openURL
            context.coordinator.customOpenURL = openURL

            textViewStore.didUpdateTextView(nsView)
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
    }

#endif
