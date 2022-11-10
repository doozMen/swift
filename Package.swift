// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "AirbnbSwift",
  platforms: [.macOS(.v10_13)],
  products: [
    .plugin(name: "FormatSwift", targets: ["FormatSwift"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.3"),
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
        "swiftformat",
        "swiftlint",
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

    .binaryTarget(
      name: "swiftformat",
      url: "https://github.com/doozMen/SwiftFormat/releases/download/0.51-beta4/swiftformat.artifactbundle.zip",
      checksum: "f11b4e78fae995a211df87f0bf89f00bbccfecae42074d20e2b8e15b296200dd"),
    .binaryTarget(
      name: "swiftlint",
      url: "https://github.com/doozMen/SwiftLint/releases/download/0.49.1/swiftlint.artifactbundle.zip",
      checksum: "aefc21b6d9311ed3e29042ae22c815506d8b0c7c2a8cfe9995ae6e813db4b5e4"),
  ])
