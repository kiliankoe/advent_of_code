// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [
        .package(url: "https://github.com/sharplet/Regex", from: "2.1.1"),
    ],
    targets: [
        .target(name: "Util"),
        .target(
            name: "Day1",
            resources: [
                .process("Resources")
            ]),
        .target(
            name: "Day2",
            dependencies: ["Regex"]),
        .target(name: "Day3"),
        .target(
            name: "Day4",
            dependencies: ["Regex"]),
        .target(name: "Day5", dependencies: ["Util"]),
        .target(name: "Day6", dependencies: ["Util"]),
    ]
)
