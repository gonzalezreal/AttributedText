#if canImport(SwiftUI) && os(macOS)

    import SwiftUI

    @available(macOS 11.0, *)
    struct TextViewWrapper: NSViewRepresentable {
        final class View: NSTextView {
            weak var store: TextViewStore?

            var maxWidth: CGFloat {
                get { textContainer?.containerSize.width ?? 0 }
                set {
                    guard textContainer?.containerSize.width != newValue else { return }
                    textContainer?.containerSize.width = newValue
                    invalidateIntrinsicContentSize()
                }
            }

            override var intrinsicContentSize: NSSize {
                guard maxWidth > 0,
                      let textContainer = self.textContainer,
                      let layoutManager = self.layoutManager
                else {
                    return super.intrinsicContentSize
                }

                layoutManager.ensureLayout(for: textContainer)
                return layoutManager.usedRect(for: textContainer).size
            }

            override func invalidateIntrinsicContentSize() {
                super.invalidateIntrinsicContentSize()
                store?.didInvalidateIntrinsicContentSize()
            }

            func setAttributedText(_ attributedText: NSAttributedString) {
                // Avoid notifiying the store while the text storage is processing edits
                let store = self.store
                self.store = nil
                textStorage?.setAttributedString(attributedText)
                self.store = store
            }
        }

        final class Coordinator: NSObject, NSTextViewDelegate {
            var openURL: OpenURLAction?

            func textView(_: NSTextView, clickedOnLink link: Any, at _: Int) -> Bool {
                guard let url = (link as? URL) ?? (link as? String).flatMap(URL.init(string:)) else {
                    return false
                }

                openURL?(url)
                return false
            }
        }

        let attributedText: NSAttributedString
        let store: TextViewStore

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

            nsView.store = store
            store.view = nsView

            return nsView
        }

        func updateNSView(_ nsView: View, context: Context) {
            nsView.setAttributedText(attributedText)
            nsView.textContainer?.maximumNumberOfLines = context.environment.lineLimit ?? 0
            nsView.textContainer?.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)
            nsView.invalidateIntrinsicContentSize()

            context.coordinator.openURL = context.environment.openURL
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
    }

#endif
