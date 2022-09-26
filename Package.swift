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
      url: "https://github.com/doozMen/SwiftFormat/releases/download/0.49.18/swiftformat.artifactbundle.zip",
      checksum: "e375a952c9af44804d6b844333c19e75ec9bc1e47ccecbe1a6e515ac86bc078a"),

    .binaryTarget(
      name: "swiftlint",
      url: "https://github.com/doozMen/SwiftLint/releases/download/0.49.1/swiftlint.artifactbundle.zip",
      checksum: "2ee58bedc9a1f729acbebecc0861a2980b756ca4e1a131fd1d32f0db3dd201c0"),
  ])
