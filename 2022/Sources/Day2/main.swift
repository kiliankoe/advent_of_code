import Foundation
import Util

let input = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .stringContent()!
    .components(separatedBy: .newlines)
    .dropLast()


let matchSumPart1 = input
    .map {
        let match = $0
            .components(separatedBy: " ")
            .compactMap(Move.init(rawValue:))
        return match[1].score(against: match[0])
    }
    .reduce(0, +)

print("Part 1: \(matchSumPart1)")


let matchSumPart2 = input
    .map {
        let opponentMove = Move(rawValue: String($0.first!))!
        let myMove = opponentMove.move(against: String($0.last!))
        return myMove.score(against: opponentMove)
    }
    .reduce(0, +)

print("Part 2: \(matchSumPart2)")


enum Move: String {
    case rock, paper, scissors

    func score(against other: Move) -> Int {
        var score = 0
        switch (self, other) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            score += 6
        case let (lhs, rhs) where lhs == rhs:
            score += 3
        default:
            break
        }
        switch self {
        case .rock:
            score += 1
        case .paper:
            score += 2
        case .scissors:
            score += 3
        }
        return score
    }

    // Part 1

    init?(rawValue: String) {
        switch rawValue {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissors
        default:
            return nil
        }
    }

    // Part 2

    func move(against other: String) -> Move {
        if other == "Y" {
            return self
        }
        switch self {
        case .rock:
            if other == "X" {
                return .scissors
            }
            return .paper
        case .paper:
            if other == "X" {
                return .rock
            }
            return .scissors
        case .scissors:
            if other == "X" {
                return .paper
            }
            return .rock
        }
    }
}
