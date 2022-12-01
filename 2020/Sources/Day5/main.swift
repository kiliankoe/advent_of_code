import Foundation
import Util

extension ClosedRange where Bound == Int {
    var lowerHalf: ClosedRange {
        lowerBound...(lowerBound + count / 2)
    }

    var upperHalf: ClosedRange {
        (lowerBound + count / 2)...upperBound
    }
}

func decode(boardingPass: String) -> (row: Int, column: Int) {
    var row = 0...127
    var column = 0...7

    for character in boardingPass {
        switch character {
        case "F": row = row.lowerHalf
        case "B": row = row.upperHalf
        case "L": column = column.lowerHalf
        case "R": column = column.upperHalf
        default: fatalError()
        }
    }

    return (row.lowerBound, column.lowerBound)
}

func checksum(_ boardingPass: (row: Int, column: Int)) -> Int {
    boardingPass.row * 8 + boardingPass.column
}

measure {
    let checksums = inputStr.components(separatedBy: .newlines)
        .map(decode(boardingPass:))
        .map(checksum(_:))
        .sorted()

    print("Max Checksum:", checksums.last!)

    for (idx, checksum) in checksums.enumerated() {
        guard idx + 1 < checksums.count else { break }
        let next = checksums[idx + 1]
        if next != checksum + 1 {
            print("My seat:", checksum + 1)
            break
        }
    }
}
