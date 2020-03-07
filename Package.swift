// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "UIButtonActivityIndicatorExtension",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "UIButtonActivityIndicatorExtension", targets: ["UIButtonActivityIndicatorExtension"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "UIButtonActivityIndicatorExtension", dependencies: []),
    ]
)
