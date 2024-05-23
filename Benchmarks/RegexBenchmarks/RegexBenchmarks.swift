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
  
  Benchmark("BasicBuiltinCharacterClass") { benchmark in
    let re = #/\d\w/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }
  
  Benchmark("EmailBuiltinCharacterClass") { benchmark in
    let re = #/(?:\d|\w|\.|-|_|%|\+)+@(?:\d|\w|\.|-|_|%|\+)+/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.validEmails.matches(of: re))
    }
  }
  
  Benchmark("BuiltIn/Words") { benchmark in
    let re = #/\w+/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.matches(of: re))
    }
  }
  Benchmark("BuiltIn/Numbers") { benchmark in
    let re = #/\d+/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.matches(of: re))
    }
  }
  Benchmark("BuiltIn/Lines") { benchmark in
    let re = #/.+/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.matches(of: re))
    }
  }
  
  Benchmark("CSS") { benchmark in
    let re = #/--([a-zA-Z0-9_-]+)\s*:\s*(.*?);/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgCSS.matches(of: re))
    }
  }
  
  Benchmark("CCC/Basic") { benchmark in
    let re = #/[abCDeiou'~]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }
  Benchmark("CCC/BasicRange") { benchmark in
    let re = #/[a-z]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("CCC/CaseInsensitive") { benchmark in
    let re = #/(?i)[abCDeiou'~]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("CCC/Inverted") { benchmark in
    let re = #/[^jskldfjoi]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("CCC/Subtraction") { benchmark in
    let re = #/[a-z--[ae]]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("CCC/Intersection") { benchmark in
    let re = #/[a-z&&[abcdeiou]]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("CCC/SymmetricDifference") { benchmark in
    let re = #/[a-z~~[jskldfjoi]]{4,6}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

}
