import AttributedText
import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    private let attributedString: NSAttributedString = {
        let result = NSMutableAttributedString(
            string: """
            After the Big Bang
            A brief summary of time
            Life on earth
            10 billion years
            You reading this
            13.7 billion years
            """
        )

        result.addAttributes([.font: NSFont.preferredFont(forTextStyle: .title1)], range: NSRange(location: 0, length: 18))
        result.addAttributes([.link: URL(string: "https://en.wikipedia.org/wiki/Big_Bang")!], range: NSRange(location: 10, length: 8))
        result.addAttributes([.font: NSFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 19, length: 23))
        result.addAttributes([.font: NSFont.preferredFont(forTextStyle: .title2)], range: NSRange(location: 43, length: 13))
        result.addAttributes([.font: NSFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 57, length: 16))
        result.addAttributes([.font: NSFont.preferredFont(forTextStyle: .title2)], range: NSRange(location: 74, length: 16))
        result.addAttributes([.font: NSFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 91, length: 18))

        return result
    }()

    var body: some View {
        AttributedText(attributedString)
            .background(Color.gray.opacity(0.5))
            .accentColor(.purple)
    }
}

PlaygroundPage.current.setLiveView(
    ContentView()
        .frame(width: 375, height: 667)
        .background(Color.white)
)
