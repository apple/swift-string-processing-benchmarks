# `_StringProcessing` Benchmarks

This package is used to benchmark the `Regex` matching and string searching algorithms
implemented in the https://github.com/apple/swift-experimental-string-processing/ package.

## Usage

1. The `swift-experimental-string-processing` repository is defined as a local reference,
so you can update that as befits your testing needs, or point to a different location.

2. Install `jemalloc` via `brew install jemalloc`, or whatever method makes sense for you.

3. Run the benchmarks with this command, substituting your own toolchain identifier 
(found in the toolchain's _Info.plist_):

```
$ xcrun --toolchain org.swift.59202403071a swift package -c release --allow-writing-to-package-directory benchmark
```

Two unfortunate notes about the current setup:

- Saving baselines doesn't work for me (Nate) for some reason -- 
you should be able to save benchmark output by adding `baseline update BASELINE_NAME` to the command above, 
but it appears to have no effect. 
As a workaround, you can run the benchmarks twice and manually compare the output.

- Compounding matters, the benchmark only successfully builds when built from a clean state, 
perhaps due to the presence of `_StringProcessing` symbols in both the stdlib and the imported package.
