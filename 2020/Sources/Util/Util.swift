import Foundation

infix operator |> : AssignmentPrecedence
public func |><T, U>(lhs: T, rhs: (T) -> U) -> U {
    rhs(lhs)
}

public func measure(_ block: () -> Void) {
    let start = Date()
    block()
    let formattedTime = String(format: "%.2f", Date().timeIntervalSince(start) * 1000)
    print("\n\(formattedTime)ms")
}
