// swift-tools-version: 6.4
import PackageDescription

let package = Package(
  name: "SwiftCade",
  platforms: [.macOS(.v15)],
  dependencies: [
    .package(
      url: "https://github.com/SwiftTUI/swift-tui",
      .upToNextMinor(from: "0.17.0")
    ),
  ],
  targets: [
    .executableTarget(
      name: "SwiftCade",
      dependencies: [
        .product(name: "SwiftTUI", package: "swift-tui"),
      ]
    ),
  ]
)
