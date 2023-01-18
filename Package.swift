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
      checksum: "e794afb77ff7e17de3c94cd69e9547d4b692719bcebc59c86aaae345defe7668"),
    .binaryTarget(
      name: "swiftlint",
      url: "https://github.com/doozMen/SwiftLint/releases/download/0.49.1/swiftlint.artifactbundle.zip",
      checksum: "ae1f4885e7722a7aeac21215e34227b1b03e87671d040b50ff5ca854ceac016c"),
  ])
