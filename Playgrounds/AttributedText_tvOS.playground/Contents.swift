import PlaygroundSupport
import SwiftUI

import AttributedText

func makeAttributedString() -> NSAttributedString {
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

    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .title1)], range: NSRange(location: 0, length: 18))
    result.addAttributes([.link: URL(string: "https://en.wikipedia.org/wiki/Big_Bang")!], range: NSRange(location: 10, length: 8))
    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 19, length: 23))
    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .title2)], range: NSRange(location: 43, length: 13))
    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 57, length: 16))
    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .title2)], range: NSRange(location: 74, length: 16))
    result.addAttributes([.font: UIFont.preferredFont(forTextStyle: .body)], range: NSRange(location: 91, length: 18))

    return result
}

struct ContentView: View {
    var body: some View {
        VStack {
            AttributedText(makeAttributedString())
                .background(Color.gray.opacity(0.5))
        }
        .accentColor(.purple)
    }
}

PlaygroundPage.current.setLiveView(
    ContentView()
        .frame(width: 800, height: 600)
        .background(Color.yellow)
)
