// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "JustSpaceOut",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "JustSpaceOut",
            targets: ["AppModule"],
            bundleIdentifier: "com.lorenzowow.SwiftStudentChallenge",
            teamIdentifier: "X8LBXW983N",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .cloud),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)