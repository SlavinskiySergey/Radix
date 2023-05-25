// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let architecture = Target.Dependency.product(
  name: "ComposableArchitecture",
  package: "swift-composable-architecture"
)

let targets: [Target] = [
  .target(
    name: "AppCoreFeature",
    dependencies: [
      architecture,
      "LoggedInFeature",
      "LoggedOutFeature",
      "Models",
      "UserDefaultsClient"
    ]
  ),
  .target(
    name: "CredentialsFeature",
    dependencies: [
      architecture,
      "Models"
    ]
  ),
  .target(
    name: "LoggedInFeature",
    dependencies: [
      architecture,
      "Models"
    ]
  ),
  .target(
    name: "LoggedOutFeature",
    dependencies: [
      architecture,
      "CredentialsFeature",
      "PersonalInfoFeature",
      "Models",
      .product(
        name: "NavigationTransitions",
        package: "swiftui-navigation-transitions"
      ),
      "PinFeature",
      "TermsOfServiceFeature"
    ]
  ),
  .target(
    name: "Models"
  ),
  .target(
    name: "PersonalInfoFeature",
    dependencies: [
      architecture,
      "Models"
    ]
  ),
  .target(
    name: "PinFeature",
    dependencies: [
      architecture,
      "Models"
    ]
  ),
  .target(
    name: "TermsOfServiceFeature",
    dependencies: [
      architecture,
      "Models"
    ]
  ),
  .target(
    name: "UserDefaultsClient",
    dependencies: [
      architecture,
      "Models"
    ]
  )
]

let package = Package(
  name: "RadixLibrary",
  platforms: [.iOS(.v16)],
  products: targets
    .map { .library(name: $0.name, targets: [$0.name]) },
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      branch: "prerelease/1.0"
    ),
    .package(
      url: "https://github.com/davdroman/swiftui-navigation-transitions",
      from: "0.9.0"
    )
  ],
  targets: targets
)
