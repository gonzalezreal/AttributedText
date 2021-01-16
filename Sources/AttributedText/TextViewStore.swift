#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    final class TextViewStore: ObservableObject {
        @Published var intrinsicContentSize: CGSize?

        weak var view: TextViewWrapper.View?

        func onContainerSizeChange(_ containerSize: CGSize?) {
            guard let containerSize = containerSize,
                  let view = self.view else { return }

            view.maxWidth = containerSize.width
        }

        func didInvalidateIntrinsicContentSize() {
            guard let view = self.view else { return }

            intrinsicContentSize = view.intrinsicContentSize
        }
    }

#endif
