import Foundation
import Util

let rucksacks: [String] = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .puzzleInput()!

let part1Sum = rucksacks
    .map { $0.splitInMiddle() }
    .map { Set($0.0).intersection(Set($0.1)) }
    .flatMap { Array($0) }
    .map(\.priority)
    .reduce(0, +)

print(part1Sum)

let part2Sum = rucksacks
    .chunked(into: 3)
    .map {
        Set($0[0])
            .intersection(Set($0[1]))
            .intersection(Set($0[2]))
            .first!
    }
    .map(\.priority)
    .reduce(0, +)

print(part2Sum)

extension String {
    func splitInMiddle() -> (String, String) {
        let middle = self.index(self.startIndex, offsetBy: self.count / 2)
        return (String(self[..<middle]), String(self[middle...]))
    }
}

extension Character {
    var priority: Int {
        let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return chars.distance(from: chars.startIndex, to: chars.firstIndex(of: self)!) + 1
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size)
            .map {
                Array(self[$0..<Swift.min($0 + size, count)])
            }
    }
}
