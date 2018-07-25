// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "OnlineHop",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc"),
        .package(url: "git@github.com:OMTS/Hop.git", from: "0.1.2")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "Hop"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
