import Foundation
import Util

let input = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .stringContent()!
    .dropLast()

var part1Done = false
var startOfPacketBuffer = CircularBuffer<Character>(maxCapacity: 4)
var startOfMessageBuffer = CircularBuffer<Character>(maxCapacity: 14)

for (count, char) in zip(1..., input) {
    startOfPacketBuffer.add(char)
    startOfMessageBuffer.add(char)
    if startOfPacketBuffer.isUniqueAndFull && !part1Done {
        print("Part 1: \(count)")
        part1Done = true
    }
    if startOfMessageBuffer.isUniqueAndFull {
        print("Part 2: \(count)")
        break
    }
}

struct CircularBuffer<Element> {
    private(set) var values: [Element] = []
    private let maxCapacity: Int
    private var nextIndex = 0
    
    var count: Int {
        values.count
    }
    
    init(maxCapacity: Int) {
        self.maxCapacity = maxCapacity
        values.reserveCapacity(maxCapacity)
    }
    
    mutating func add(_ value: Element) {
        if count < maxCapacity {
            values.append(value)
        } else {
            values[nextIndex] = value
            nextIndex = (nextIndex + 1) % maxCapacity
        }
    }
}

extension CircularBuffer where Element: Hashable {
    var isUniqueAndFull: Bool {
        self.values.allDifferent && self.values.count == self.maxCapacity
    }
}

extension Array where Element: Hashable {
    var allDifferent: Bool {
        self.count == Set(self).count
    }
}
