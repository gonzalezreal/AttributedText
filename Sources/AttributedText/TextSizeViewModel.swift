import SwiftUI

final class TextSizeViewModel {
  @Published var textSize: CGSize?

  func didUpdateTextView(_ textView: AttributedTextImpl.TextView) {
    DispatchQueue.main.async { [weak self] in
      self?.textSize = textView.intrinsicContentSize
    }
  }
}
