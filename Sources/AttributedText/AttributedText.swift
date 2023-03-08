import SwiftUI

/// A view that displays styled attributed text.
public struct AttributedText: View {
  private var textSizeViewModel = TextSizeViewModel()
  @State private var textSize: CGSize?

  private let attributedText: NSAttributedString
  private let onOpenLink: ((URL) -> Void)?

  /// Creates an attributed text view.
  /// - Parameters:
  ///   - attributedText: An attributed string to display.
  ///   - onOpenLink: The action to perform when the user opens a link in the text. When not specified,
  ///                 the  view opens the links using the `OpenURLAction` from the environment.
  public init(_ attributedText: NSAttributedString, onOpenLink: ((URL) -> Void)? = nil) {
    self.attributedText = attributedText
    self.onOpenLink = onOpenLink
  }

  /// Creates an attributed text view.
  /// - Parameters:
  ///   - attributedText: A closure that creates the attributed string to display.
  ///   - onOpenLink: The action to perform when the user opens a link in the text. When not specified,
  ///                 the  view opens the links using the `OpenURLAction` from the environment.
  public init(attributedText: () -> NSAttributedString, onOpenLink: ((URL) -> Void)? = nil) {
    self.init(attributedText(), onOpenLink: onOpenLink)
  }

  public var body: some View {
    GeometryReader { geometry in
      AttributedTextImpl(
        attributedText: attributedText,
        maxLayoutWidth: geometry.maxWidth,
        textSizeViewModel: textSizeViewModel,
        onOpenLink: onOpenLink
      )
    }
    .frame(
      idealWidth: textSize?.width,
      idealHeight: textSize?.height
    )
    .fixedSize(horizontal: false, vertical: true)
    .onReceive(textSizeViewModel.$textSize) { size in
        textSize = size
    }
  }
}

extension GeometryProxy {
  fileprivate var maxWidth: CGFloat {
    size.width - safeAreaInsets.leading - safeAreaInsets.trailing
  }
}

extension View {
  /// Set the attributes used to draw the onscreen presentation of link text.
  /// - Parameter linkTextAttributes: The attributes used to draw the onscreen presentation of link text.
  /// - Returns: A view with the linkTextAttributes set to the value you supply.
  public func linkTextAttributes(_ linkTextAttributes: [NSAttributedString.Key: Any]) -> some View {
    environment(\.linkTextAttributes, linkTextAttributes)
  }

  /// Set the attributes used to draw the onscreen presentation of link text.
  /// - Parameter linkTextAttributes: A closure that creates the attributes used to draw the onscreen presentation of link text.
  /// - Returns: A view with the linkTextAttributes set to the value you supply.
  public func linkTextAttributes(_ linkTextAttributes: () -> [NSAttributedString.Key: Any]) -> some View {
    environment(\.linkTextAttributes, linkTextAttributes())
  }
}

extension EnvironmentValues {
  internal var linkTextAttributes: [NSAttributedString.Key: Any]? {
    get { self[LinkTextAttributesKey.self] }
    set { self[LinkTextAttributesKey.self] = newValue }
  }
}

private struct LinkTextAttributesKey: EnvironmentKey {
  static let defaultValue: [NSAttributedString.Key: Any]? = nil
}
