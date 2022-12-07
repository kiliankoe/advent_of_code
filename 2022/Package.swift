// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    dependencies: [],
    targets: [
        .target(name: "Util"),
        .executableTarget(
            name: "Day1",
            dependencies: ["Util"],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .executableTarget(
            name: "Day2",
            dependencies: ["Util"],
            resources: [
                .copy("example.txt"),
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day3",
            dependencies: ["Util"],
            resources: [
                .copy("example.txt"),
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day4",
            dependencies: ["Util"],
            resources: [
                .copy("example.txt"),
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day5",
            dependencies: ["Util"],
            resources: [
                .copy("example.txt"),
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day6",
            dependencies: ["Util"],
            resources: [
                .copy("example.txt"),
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day7",
            dependencies: ["Util"],
            resources: [
                .copy("example.txt"),
                .copy("input.txt")
            ]
        ),
    ]
)
