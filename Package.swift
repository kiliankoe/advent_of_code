// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [],
    targets: [
        .target(
            name: "Day1",
            dependencies: [],
            resources: [
                .process("Resources")
            ]),
    ]
)
