#if !os(macOS) && !targetEnvironment(macCatalyst)
    import SnapshotTesting
    import SwiftUI
    import XCTest

    import AttributedText

    final class AttributedTextTests: XCTestCase {
        struct TestView: View {
            var body: some View {
                AttributedText {
                    let result = NSMutableAttributedString(
                        string: """
                        The Adventures of Sherlock Holmes
                        I had called upon my friend, Mr. Sherlock Holmes, one day in the autumn of last year and found him in deep conversation with a very stout, florid-faced, elderly gentleman with fiery red hair.
                        """
                    )

                    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .title2)], range: NSRange(location: 0, length: 33))
                    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 33, length: 192))
                    return result
                }
                .background(Color.gray.opacity(0.5))
                .padding()
            }
        }

        private let precision: Float = 0.99

        #if os(iOS)
            private let layout = SwiftUISnapshotLayout.device(config: .iPhone8)
            private let platformName = "iOS"
        #elseif os(tvOS)
            private let layout = SwiftUISnapshotLayout.device(config: .tv)
            private let platformName = "tvOS"
        #endif

        func testHeight() {
            let view = TestView()
            assertSnapshot(matching: view, as: .image(precision: precision, layout: layout), named: platformName)
        }

        func testLineLimit() {
            let view = TestView()
                .lineLimit(2)
            assertSnapshot(matching: view, as: .image(precision: precision, layout: layout), named: platformName)
        }

        func testTruncationMode() {
            let view = TestView()
                .lineLimit(2)
                .truncationMode(.middle)
            assertSnapshot(matching: view, as: .image(precision: precision, layout: layout), named: platformName)
        }
    }
#endif
