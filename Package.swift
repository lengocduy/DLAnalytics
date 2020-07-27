// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "DLAnalytics",
    products: [
        .library(name: "DLAnalytics", targets: ["DLAnalytics"])
    ],
    targets: [
        .target(
            name: "DLAnalytics",
            path: ".",
            dependencies: [])
    ]
)
