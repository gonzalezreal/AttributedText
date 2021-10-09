// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AttributedText",
  platforms: [
    .macOS(.v11),
    .iOS(.v14),
    .tvOS(.v14),
  ],
  products: [
    .library(
      name: "AttributedText",
      targets: ["AttributedText"]
    )
  ],
  dependencies: [
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      from: "1.9.0"
    )
  ],
  targets: [
    .target(
      name: "AttributedText",
      dependencies: []
    ),
    .testTarget(
      name: "AttributedTextTests",
      dependencies: ["AttributedText", "SnapshotTesting"],
      exclude: ["__Snapshots__"]
    ),
  ]
)
