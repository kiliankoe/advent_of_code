import Foundation
import Util

let calorieCounts = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .stringContent()!
    .components(separatedBy: .newlines)
    .reduce(into: [0]) { counts, meal in
        guard meal != "" else {
            counts.append(0)
            return
        }
        counts[counts.indices.last!] += Int(meal)!
        return
    }
    .sorted(by: >)

print("Checked \(calorieCounts.count) elves")
print("Highest calorie count: \(calorieCounts.first!)")
print("Sum of top three: \(calorieCounts.prefix(3).reduce(0, +))")
