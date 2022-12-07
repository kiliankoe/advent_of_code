import Foundation
import Util

let input = Bundle.module
    .url(forResource: "input", withExtension: "txt")!
    .puzzleInput()!
    .dropFirst()

var rootDir = Directory(path: "/", directories: [])
var currentDir = rootDir

for line in input {
    if line.hasPrefix("$") {
        if line == "$ ls" { continue }
        let cdDir = line.components(separatedBy: "cd ")[1]
        if cdDir == ".." {
            currentDir = currentDir.parent!
        } else {
            currentDir = currentDir.subDirs.first { $0.name == cdDir }!
        }
    } else if line.hasPrefix("dir") {
        let dirName = line.components(separatedBy: "dir ")[1]
        currentDir.subDirs.append(Directory(path: dirName, parent: currentDir))
    } else {
        currentDir.fileSize += Int(line.components(separatedBy: " ")[0])!
    }
}

var sum = 0
var sizeToFree = rootDir.size - 40_000_000
var smallestToDelete: Directory?

rootDir.traverse { dir in
    if dir.size <= 100_000 {
        sum += dir.size
    }
    if dir.size > sizeToFree && dir.size < smallestToDelete?.size ?? Int.max {
        smallestToDelete = dir
    }
}
print("Part 1: \(sum)")
print("Part 2: \(smallestToDelete!.name) with \(smallestToDelete!.size).")

class Directory {
    var name: String
    var fileSize: Int = 0
    var subDirs: [Directory]
    var parent: Directory?
    
    init(
        path: String,
        directories: [Directory] = [],
        parent: Directory? = nil
    ) {
        self.name = path
        self.subDirs = directories
        self.parent = parent
    }
    
    var size: Int {
        fileSize + self.subDirs.map(\.size).reduce(0, +)
    }
    
    func traverse(_ handler: (Directory) -> Void) {
        handler(self)
        self.subDirs.forEach { $0.traverse(handler) }
    }
}
