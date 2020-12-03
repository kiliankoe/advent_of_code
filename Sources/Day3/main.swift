import Foundation

extension String {
    subscript(wrapping offset: Int) -> Character {
        get {
            guard offset < self.count else {
                let diff = offset % self.count
                return self[self.index(self.startIndex, offsetBy: diff)]
            }
            return self[self.index(self.startIndex, offsetBy: offset)]
        }
    }
}

let map = inputStr.components(separatedBy: .newlines)

func traverse(position: (Int, Int), right: Int, down: Int) -> Int {
    guard map.count > position.1 else { return 0 }
    let tree = map[position.1][wrapping: position.0] == "#" ? 1 : 0
    return tree + traverse(position: (position.0 + right, position.1 + down), right: right, down: down)
}

let slopes = [
    (right: 1, down: 1),
    (right: 3, down: 1),
    (right: 5, down: 1),
    (right: 7, down: 1),
    (right: 1, down: 2),
]

let treesProduct = slopes
    .map { traverse(position: (0, 0), right: $0.right, down: $0.down) }
    .reduce(1, *)

print(treesProduct)
