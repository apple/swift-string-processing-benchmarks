import Benchmark
import _StringProcessing
import TestData

let benchmarks = {
  Benchmark("firstRange/Devanagari") { benchmark in
    for _ in benchmark.scaledIterations {
      let index = TestData.taggedDevanagari.firstRange(of: #/यबऋॉलफ़/#)
      blackHole(index)
    }
  }

  Benchmark("firstRange/HTML") { benchmark in
    for _ in benchmark.scaledIterations {
      let index = TestData.swiftOrgHTML.firstRange(of: #/\/assets\/.+\/application\.js/#)
      blackHole(index)
    }
  }

  Benchmark("ReluctantQuant") { benchmark in
    let input = String(repeating: "a", count: 100_000)
    benchmark.startMeasurement()
    for _ in benchmark.scaledIterations {
      blackHole(input.wholeMatch(of: #/.*?/#))
    }
  }

  Benchmark("EagarQuantWithTerminal") { benchmark in
    let input = String(repeating: "a", count: 100_000) + ";"
    benchmark.startMeasurement()
    for _ in benchmark.scaledIterations {
      blackHole(input.wholeMatch(of: #/.*;/#))
    }
  }

  Benchmark("ReluctantQuantWithTerminal") { benchmark in
    let input = String(repeating: "a", count: 100_000) + ";"
    benchmark.startMeasurement()
    for _ in benchmark.scaledIterations {
      blackHole(input.wholeMatch(of: #/.*?;/#))
    }
  }
}
