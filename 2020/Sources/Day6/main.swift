import Foundation
import Util

measure {
    let part1 = inputStr.components(separatedBy: "\n\n")
        .map { $0.replacingOccurrences(of: "\n", with: "") }
        .map(Set.init)
        .map { $0.count }
        .reduce(0, +)
    print("Sum of questions anybody answered yes to:", part1)

    let part2 = inputStr.components(separatedBy: "\n\n")
        .map { $0.components(separatedBy: .newlines) }
        .map { group -> Int in
            var dict = [Character: Int]()
            for person in group {
                for question in person {
                    dict[question, default: 0] += 1
                }
            }
            var allYes = 0
            for (_, count) in dict {
                if count == group.count {
                    allYes += 1
                }
            }
            return allYes
        }
        .reduce(0, +)

    print("Sum of questions everybody answered yes to:", part2)
}
