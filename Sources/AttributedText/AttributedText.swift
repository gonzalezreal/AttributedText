#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    public struct AttributedText: View {
        @StateObject private var store = TextViewStore()

        private let attributedText: NSAttributedString

        public init(_ attributedText: NSAttributedString) {
            self.attributedText = attributedText
        }

        public var body: some View {
            GeometryReader { geometry in
                TextViewWrapper(attributedText: attributedText, store: store)
                    .preference(key: ContainerSizePreference.self, value: geometry.maxSize)
            }
            .onPreferenceChange(ContainerSizePreference.self) { value in
                store.onContainerSizeChange(value)
            }
            .frame(
                idealWidth: store.intrinsicContentSize?.width,
                idealHeight: store.intrinsicContentSize?.height
            )
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    private extension GeometryProxy {
        var maxSize: CGSize {
            CGSize(
                width: size.width - safeAreaInsets.leading - safeAreaInsets.trailing,
                height: size.height - safeAreaInsets.top - safeAreaInsets.bottom
            )
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    private struct ContainerSizePreference: PreferenceKey {
        static var defaultValue: CGSize?

        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = nextValue()
        }
    }

#endif
