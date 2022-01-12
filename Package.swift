// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "PhoneNumberKit",
  platforms: [
    .iOS(.v13), .macOS(.v11), .tvOS(.v14), .watchOS(.v6)
  ],
  products: [
    .library(name: "PhoneNumberKit", targets: ["PhoneNumberKit"]),
    .library(name: "PhoneNumberKit-Static", type: .static, targets: ["PhoneNumberKit"]),
    .library(name: "PhoneNumberKit-Dynamic", type: .dynamic, targets: ["PhoneNumberKit"])
  ],
  targets: [
    .target(name: "PhoneNumberKit",
            path: "PhoneNumberKit",
            exclude: ["Resources/Original",
                      "Resources/README.md",
                      "Resources/update.sh",
                      "Info.plist"],
            resources: [
              .process("Resources/PhoneNumberMetadata.json")
            ]),
    .testTarget(name: "PhoneNumberKitTests",
                dependencies: ["PhoneNumberKit"],
                path: "PhoneNumberKitTests",
                exclude: ["Info.plist"])
  ]
)
