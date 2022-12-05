import Foundation
import Util

let input = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .stringContent()!
    .components(separatedBy: "\n\n")

let (stackDescription, instructions) = (input[0], input[1])

var stacks1 = Dock(stacks: stackDescription)
var stacks2 = Dock(stacks: stackDescription)

let moveRegex = try Regex(#"\d+"#)

instructions
    .components(separatedBy: .newlines)
    .dropLast()
    .map { instruction in
        let matches = instruction.matches(of: moveRegex)
        return matches
            .map { 
                Int(instruction[$0.range.lowerBound..<$0.range.upperBound])!
            }
    }
    .map { (count: $0[0], from: $0[1], to: $0[2]) }
    .forEach {
        stacks1.move9000(count: $0.count, from: $0.from, to: $0.to)
        stacks2.move9001(count: $0.count, from: $0.from, to: $0.to)
    }

print(stacks1.topCratesString)
print(stacks2.topCratesString)

struct Dock {
    var stacks: [Int: [Character]]
    
    init(stacks: String) {
        let characterStacks = stacks
            .components(separatedBy: .newlines)
            .rotatedLeft()
            .filter { $0.contains(try! Regex("[A-Z]")) }
            .map { 
                Array(
                    $0.trimmingCharacters(in: .whitespaces) 
                      .dropLast()
                )
            }
        
        self.stacks = Dictionary(uniqueKeysWithValues: zip(1..., characterStacks))
    }
    
    mutating func move9000(count: Int, from: Int, to: Int) {
        for _ in 0..<count {
            let crate = stacks[from]!.removeFirst()
            stacks[to]!.insert(crate, at: 0)
        }
    }
    
    mutating func move9001(count: Int, from: Int, to: Int) {
        let crates = stacks[from]!.prefix(count)
        stacks[from] = Array(stacks[from]!.dropFirst(count))
        stacks[to]!.insert(contentsOf: crates, at: 0)
    }
    
    var topCratesString: String {
        stacks
            .sorted { $0.key < $1.key }
            .map { String($0.value.first ?? " ") }
            .joined()
    }
}

extension Array where Element == String {
    func rotatedLeft() -> [String] {
        self.reduce(into: [String](repeating: "", count: self[0].count)) {
            for (idx, char) in $1.enumerated() {
                $0[idx] += String(char)
            }
        }
    }
}
