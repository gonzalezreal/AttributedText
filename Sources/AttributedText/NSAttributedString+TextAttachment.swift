#if os(macOS)
    import AppKit
#elseif canImport(UIKit)
    import UIKit
#endif

extension NSAttributedString {
    func updateImageTextAttachments(maxWidth: CGFloat) {
        enumerateAttribute(.attachment, in: NSRange(location: 0, length: length), options: []) { value, _, _ in
            guard let attachment = value as? NSTextAttachment,
                  let image = attachment.image else { return }

            let aspectRatio = image.size.width / image.size.height
            let width = min(maxWidth, image.size.width)
            let height = width / aspectRatio

            attachment.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }
}
