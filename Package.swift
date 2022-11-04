// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "AirbnbSwift",
  platforms: [.macOS(.v12)],
  products: [
    .plugin(name: "FormatSwift", targets: ["FormatSwift"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.3"),
    // points to https://github.com/calda/SwiftFormat/releases/tag/0.51-beta-3 as the tag could not be used in that format
    // swiftformat is included directly to be able to support linux too
    .package(url: "https://github.com/calda/SwiftFormat", revision: "b9aa1814747d37c86fd1553d8dfefbe7557f8c34"),
    .package(url: "https://github.com/realm/SwiftLint", branch: "main"),
  ],
  targets: [
    .plugin(
      name: "FormatSwift",
      capability: .command(
        intent: .custom(
          verb: "format",
          description: "Formats Swift source files according to the Airbnb Swift Style Guide"),
        permissions: [
          .writeToPackageDirectory(reason: "Format Swift source files"),
        ]),
      dependencies: [
        "AirbnbSwiftFormatTool",
        .product(name: "swiftformat", package: "SwiftFormat"),
        .product(name: "swiftlint", package: "SwiftLint"),
      ]),

    .executableTarget(
      name: "AirbnbSwiftFormatTool",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ],
      resources: [
        .process("airbnb.swiftformat"),
        .process("swiftlint.yml"),
      ]),
  ])
