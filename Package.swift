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
      checksum: "0255d8db7a8955467e7e548f9fbeda489fe0d5084d59d5144e662eb9e0bdc3d4"),
    .binaryTarget(
      name: "swiftlint",
      url: "https://github.com/doozMen/SwiftLint/releases/download/0.49.1/swiftlint.artifactbundle.zip",
      checksum: "97a3983a13f68c138069c2bd49fa047ced24b8be2367182ee04823063c49f6ae"),
  ])
