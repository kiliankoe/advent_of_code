import Foundation
import Util

let rangePairs = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .puzzleInput()!
    .map { $0.components(separatedBy: ",") }
    .map { (ClosedRange(puzzle: $0[0]), ClosedRange(puzzle: $0[1])) }

let part1 = rangePairs
    .filter { $0.0.fullyContains(other: $0.1) || $0.1.fullyContains(other: $0.0) }
    .count

print(part1)

let part2 = rangePairs
    .filter { $0.0.overlaps($0.1) }
    .count

print(part2)

extension ClosedRange where Bound == Int {
    init(puzzle str: String) {
        let bounds = str.components(separatedBy: "-")
        self.init(uncheckedBounds: (lower: Int(bounds[0])!, upper: Int(bounds[1])!))
    }

    func fullyContains(other: ClosedRange<Int>) -> Bool {
        self.lowerBound <= other.lowerBound && self.upperBound >= other.upperBound
    }
}
