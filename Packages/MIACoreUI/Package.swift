// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MIACoreUI",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MIACoreUI",
            targets: ["MIACoreUI"]),
    ],
    dependencies: [
        .package(path: "../MIACore"),
        .package(path: "../MIACoreNetworking"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MIACoreUI",
            dependencies: ["MIACore", "MIACoreNetworking"],
            path: "Sources"
        ),
        .testTarget(
            name: "MIACoreUITests",
            dependencies: ["MIACoreUI"]
        ),
    ]
)

extension String {
    static let miaCoreUI = "MIACoreUI"
}
