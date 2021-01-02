#if !os(watchOS)

    import CoreGraphics
    import Foundation

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    final class AttributedTextStore: ObservableObject {
        @Published var height: CGFloat?

        var attributedTextView: AttributedTextView?

        func onContainerSizeChange(_ containerSize: CGSize?) {
            guard let containerSize = containerSize, containerSize != .zero,
                  let attributedTextView = self.attributedTextView else { return }

            attributedTextView.preferredMaxLayoutWidth = containerSize.width
            height = attributedTextView.intrinsicContentSize.height
        }

        func onUpdateView() {
            guard let attributedTextView = self.attributedTextView,
                  attributedTextView.preferredMaxLayoutWidth > 0 else { return }
            height = attributedTextView.intrinsicContentSize.height
        }
    }

#endif
