// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MIAPackages",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MIAPackages",
            targets: ["MIACoreUI", "MIACoreNetworking", "MIACore"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MIACore",
            path: "MIACore"
        ),
        .target(
            name: "MIACoreNetworking",
            dependencies: [
                .target(name: "MIACore")
            ],
            path: "MIACoreNetworking"
        ),
        .target(
            name: "MIACoreUI",
            dependencies: [
                .target(name: "MIACore"),
                .target(name: "MIACoreNetworking")
            ],
            path: "MIACoreUI"
        )
    ]
)
