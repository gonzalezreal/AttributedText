#if canImport(UIKit) && !os(watchOS) && !targetEnvironment(macCatalyst)

    import SwiftUI

    @available(iOS 14.0, tvOS 14.0, *)
    struct TextViewWrapper: UIViewRepresentable {
        final class View: UITextView {
            weak var store: TextViewStore?

            var maxWidth: CGFloat = 0 {
                didSet {
                    guard maxWidth != oldValue else { return }
                    invalidateIntrinsicContentSize()
                }
            }

            override var intrinsicContentSize: CGSize {
                guard maxWidth > 0 else {
                    return super.intrinsicContentSize
                }

                return sizeThatFits(
                    CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
                )
            }

            override func invalidateIntrinsicContentSize() {
                super.invalidateIntrinsicContentSize()
                store?.didInvalidateIntrinsicContentSize()
            }

            func setAttributedText(_ attributedText: NSAttributedString) {
                // Avoid notifiying the store while the text storage is processing edits
                let store = self.store
                self.store = nil
                self.attributedText = attributedText
                self.store = store
            }
        }

        final class Coordinator: NSObject, UITextViewDelegate {
            var openURL: OpenURLAction?

            func textView(_: UITextView, shouldInteractWith URL: URL, in _: NSRange, interaction _: UITextItemInteraction) -> Bool {
                openURL?(URL)
                return false
            }
        }

        let attributedText: NSAttributedString
        let store: TextViewStore

        func makeUIView(context: Context) -> View {
            let uiView = View()

            uiView.backgroundColor = .clear
            uiView.textContainerInset = .zero
            #if !os(tvOS)
                uiView.isEditable = false
            #endif
            uiView.isScrollEnabled = false
            uiView.textContainer.lineFragmentPadding = 0
            uiView.delegate = context.coordinator

            uiView.store = store
            store.view = uiView

            return uiView
        }

        func updateUIView(_ uiView: View, context: Context) {
            uiView.setAttributedText(attributedText)
            uiView.textContainer.maximumNumberOfLines = context.environment.lineLimit ?? 0
            uiView.textContainer.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)
            uiView.invalidateIntrinsicContentSize()

            context.coordinator.openURL = context.environment.openURL
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
    }

#endif
