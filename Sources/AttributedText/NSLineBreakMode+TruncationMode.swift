#if !os(watchOS)
    import SwiftUI

    extension NSLineBreakMode {
        @available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
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
