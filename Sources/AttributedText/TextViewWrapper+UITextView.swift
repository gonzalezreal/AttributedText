#if canImport(UIKit) && !os(watchOS)

    import SwiftUI

    @available(iOS 14.0, tvOS 14.0, macCatalyst 14.0, *)
    struct TextViewWrapper: UIViewRepresentable {
        final class View: UITextView {
            var maxLayoutWidth: CGFloat = 0 {
                didSet {
                    guard maxLayoutWidth != oldValue else { return }
                    invalidateIntrinsicContentSize()
                }
            }

            override var intrinsicContentSize: CGSize {
                guard maxLayoutWidth > 0 else {
                    return super.intrinsicContentSize
                }

                return sizeThatFits(
                    CGSize(width: maxLayoutWidth, height: .greatestFiniteMagnitude)
                )
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
        let maxLayoutWidth: CGFloat
        let textViewStore: TextViewStore

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

            return uiView
        }

        func updateUIView(_ uiView: View, context: Context) {
            uiView.attributedText = attributedText
            uiView.maxLayoutWidth = maxLayoutWidth

            uiView.textContainer.maximumNumberOfLines = context.environment.lineLimit ?? 0
            uiView.textContainer.lineBreakMode = NSLineBreakMode(truncationMode: context.environment.truncationMode)

            context.coordinator.openURL = context.environment.openURL

            textViewStore.didUpdateTextView(uiView)
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
    }

#endif
