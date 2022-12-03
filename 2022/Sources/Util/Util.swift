import Foundation

extension URL {
    public func stringContent() -> String? {
        try? String(contentsOf: self)
    }
}

public func measure(_ block: () -> Void) {
    let start = Date()
    block()
    let formattedTime = String(format: "%.2f", Date().timeIntervalSince(start) * 1000)
    print("\n\(formattedTime)ms")
}
