#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    public struct AttributedText: View {
        @StateObject private var store = AttributedTextStore()

        private let attributedText: NSAttributedString

        public init(_ attributedText: NSAttributedString) {
            self.attributedText = attributedText
        }

        public var body: some View {
            GeometryReader { proxy in
                AttributedTextViewWrapper(attributedText: attributedText, store: store)
                    .preference(key: ContainerSizePreference.self, value: proxy.size)
            }
            .onPreferenceChange(ContainerSizePreference.self) { value in
                store.onContainerSizeChange(value)
            }
            .frame(height: store.height)
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    private struct ContainerSizePreference: PreferenceKey {
        static var defaultValue: CGSize?

        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }

#endif
