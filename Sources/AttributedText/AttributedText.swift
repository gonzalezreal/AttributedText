#if !os(watchOS)
  import SwiftUI

  public struct AttributedText: View {
    @StateObject private var textSizeViewModel = TextSizeViewModel()

    private let attributedText: NSAttributedString
    private let openLink: ((URL) -> Void)?

    public init(_ attributedText: NSAttributedString, openLink: ((URL) -> Void)? = nil) {
      self.attributedText = attributedText
      self.openLink = openLink
    }

    public init(openLink: ((URL) -> Void)? = nil, attributedText: () -> NSAttributedString) {
      self.init(attributedText(), openLink: openLink)
    }

    public var body: some View {
      GeometryReader { geometry in
        AttributedTextImpl(
          attributedText: attributedText,
          maxLayoutWidth: geometry.maxWidth,
          textSizeViewModel: textSizeViewModel,
          openLink: openLink
        )
      }
      .frame(
        idealWidth: textSizeViewModel.textSize?.width,
        idealHeight: textSizeViewModel.textSize?.height
      )
      .fixedSize(horizontal: false, vertical: true)
    }
  }

  extension GeometryProxy {
    fileprivate var maxWidth: CGFloat {
      size.width - safeAreaInsets.leading - safeAreaInsets.trailing
    }
  }
#endif
