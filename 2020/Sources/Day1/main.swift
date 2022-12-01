import Foundation

let inputFile = Bundle.module.url(forResource: "input", withExtension: "txt")!
let input = try! String(contentsOf: inputFile)
    .components(separatedBy: .newlines)
    .compactMap(Int.init)

for entry in input {
    for match in input {
        for match2 in input {
            if entry + match + match2 == 2020 {
                print(entry, match, match2, entry * match * match2)
                exit(0)
            }
        }
    }
}
