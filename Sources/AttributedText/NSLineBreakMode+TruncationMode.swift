#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    extension NSLineBreakMode {
        @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
        init(truncationMode: Text.TruncationMode) {
            switch truncationMode {
            case .head:
                self = .byTruncatingHead
            case .tail:
                self = .byTruncatingTail
            case .middle:
                self = .byTruncatingMiddle
            @unknown default:
                self = .byWordWrapping
            }
        }
    }

#endif
