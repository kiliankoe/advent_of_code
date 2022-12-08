import Foundation
import Util

let input = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .puzzleInput()!

var trees: [[Int]] = Array(repeating: [], count: input.first!.count)
for (idx, row) in zip(0..., input) {
    for tree in row {
        trees[idx].append(Int(String(tree))!)
    }
}

var visibleFromOutside = 0

for (rowIdx, row) in trees.enumerated() {
    if rowIdx == 0 || rowIdx == trees.indices.last! {
        visibleFromOutside += row.count
        continue
    }
    for (columnIdx, tree) in row.enumerated() {
        if columnIdx == 0 || columnIdx == row.indices.last! {
            visibleFromOutside += 1
            continue
        }
        
        // north 
        if (0..<rowIdx)
            .map({ trees[$0][columnIdx] })
            .allSatisfy({ $0 < tree }) {
            visibleFromOutside += 1
            continue
        }
        
        // west
        if (0..<columnIdx)
            .map({ trees[rowIdx][$0] })
            .allSatisfy({ $0 < tree }) {
            visibleFromOutside += 1
            continue
        }
        
        // south
        if ((rowIdx + 1)..<trees.count)
            .map({ trees[$0][columnIdx] })
            .allSatisfy({ $0 < tree }) {
            visibleFromOutside += 1
            continue
        }
        
        // east
        if ((columnIdx + 1)..<row.count)
            .map({ trees[rowIdx][$0] })
            .allSatisfy({ $0 < tree }) {
            visibleFromOutside += 1
            continue
        }
    }
}

print("\(visibleFromOutside) trees visible from outside.")

var highestScenicScore = 0
for (rowIdx, row) in trees.enumerated() {
    for (columnIdx, tree) in row.enumerated() {
        let northScore = (0..<rowIdx)
            .reversed()
            .map { trees[$0][columnIdx] }
            .scenicScore(fromHeight: tree)
        let westScore = (0..<columnIdx)
            .reversed()
            .map { trees[rowIdx][$0] }
            .scenicScore(fromHeight: tree)
        let southScore = ((rowIdx + 1)..<trees.count)
            .map { trees[$0][columnIdx] }
            .scenicScore(fromHeight: tree)
        let eastScore = ((columnIdx + 1)..<row.count)
            .map { trees[rowIdx][$0] }
            .scenicScore(fromHeight: tree)
        let scenicScore = northScore * westScore * southScore * eastScore
        highestScenicScore = max(highestScenicScore, scenicScore)
    }
}

print("Highest scenic score: \(highestScenicScore)")

extension Array<Int> {
    func scenicScore(fromHeight: Int) -> Int {
        var score = 0
        for tree in self {
            guard tree < fromHeight else {
                score += 1
                return score
            }
            score += 1
        }
        return score
    }
}
