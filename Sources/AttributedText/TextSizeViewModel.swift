import SwiftUI

final class TextSizeViewModel {
  @Published var textSize: CGSize?

  func didUpdateTextView(_ textView: AttributedTextImpl.TextView) {
    textSize = textView.intrinsicContentSize
  }
}
