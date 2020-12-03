// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [
        .package(url: "https://github.com/sharplet/Regex", from: "2.1.1"),
    ],
    targets: [
        .target(
            name: "Day1",
            resources: [
                .process("Resources")
            ]),
        .target(
            name: "Day2",
            dependencies: ["Regex"]),
        .target(name: "Day3"),
    ]
)
