// swift-tools-version: 5.10
import PackageDescription

let commonSettings: [SwiftSetting] = [
  .unsafeFlags(["-Xfrontend", "-disable-implicit-string-processing-module-import"]),
]
let commonDependencies: [Target.Dependency] = [
  .product(name: "Benchmark", package: "package-benchmark"),
  "TestData",
]
let commonPlugins: [Target.PluginUsage] = [
  .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
]

let package = Package(
  name: "swift-string-processing-benchmarks",
  platforms: [.macOS(.v13)],
  dependencies: [
    .package(path: "../swift-experimental-string-processing"),
    .package(url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.4.0")),
  ],
  targets: [
    .target(name: "TestData"),

    .executableTarget(
      name: "StringAlgorithmsBenchmarks",
      dependencies: commonDependencies,
      path: "Benchmarks/StringAlgorithmsBenchmarks",
      swiftSettings: commonSettings,
      plugins: commonPlugins
    ),
    .executableTarget(
      name: "RegexBenchmarks",
      dependencies: commonDependencies,
      path: "Benchmarks/RegexBenchmarks",
      swiftSettings: commonSettings,
      plugins: commonPlugins
    ),
  ]
  
)
