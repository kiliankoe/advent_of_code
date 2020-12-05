import Foundation
import Util

func decode(boardingPass: String) -> (row: Int, column: Int) {
    var rows = Array(0...127)
    for (idx, char) in boardingPass.prefix(7).enumerated() {
        let valueCount = Int(pow(2.0, Double(6 - idx)))
        if char == "F" {
            rows = Array(rows.prefix(valueCount))
        } else {
            rows = Array(rows.suffix(valueCount))
        }
    }

    var columns = Array(0...7)
    for (idx, char) in boardingPass.suffix(3).enumerated() {
        let valueCount = Int(pow(2.0, Double(2 - idx)))
        if char == "L" {
            columns = Array(columns.prefix(valueCount))
        } else {
            columns = Array(columns.suffix(valueCount))
        }
    }

    return (rows[0], columns[0])
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
