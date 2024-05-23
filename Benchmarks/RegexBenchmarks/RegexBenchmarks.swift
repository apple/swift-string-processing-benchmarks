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
  
  Benchmark("BuiltIn/Basic") { benchmark in
    let re = #/\d\w/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
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

  Benchmark("DiceRolls/Text") { benchmark in
    let re = #/(?:(?:\d+)?(?:d|D)(?:\d+)\+?)+/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.diceRollsInText.matches(of: re))
    }
  }
  Benchmark("DiceRolls/Notation") { benchmark in
    let re = #/(?:(?:\d+)?(?:d|D)(?:\d+)\+?)+/#
    for _ in benchmark.scaledIterations {
      let c = TestData.diceRolls.count(where: { $0.wholeMatch(of: re) != nil })
      blackHole(c)
    }
  }

  Benchmark("Email/BuiltinCharacterClass") { benchmark in
    let re = #/(?:\d|\w|\.|-|_|%|\+)+@(?:\d|\w|\.|-|_|%|\+)+/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.validEmails.matches(of: re))
    }
  }
  Benchmark("Email/RFC") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.validEmails.matches(of: emailRFC))
    }
  }
  Benchmark("Email/RFCNoMatches") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: emailRFC))
    }
  }
  Benchmark("Email/Lookahead") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.validEmails.matches(of: emailWithLookaheads))
    }
  }
  Benchmark("Email/LookaheadNoMatches") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: emailWithLookaheads))
    }
  }
  Benchmark("Email/LookaheadList") { benchmark in
    for _ in benchmark.scaledIterations {
      let c = TestData.validEmailsList
        .count(where: { $0.wholeMatch(of: emailWithLookaheads) != nil })
      blackHole(c)
    }
  }

  Benchmark("CompilerMessages") { benchmark in
    let re = #/(?:.*):(?:\d+):(?:\d+): (?:error|warning): (.*)/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.compilerOutput.matches(of: re))
    }
  }
  
  Benchmark("GraphemeBreak/NoCap") { benchmark in
    let re = #/(?:[0-9A-F]+)(?:\.\.(?:[0-9A-F]+))?\s+;\s+(?:\w+).*/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }
  Benchmark("GraphemeBreak/HangulSyllable") { benchmark in
    let re = #/HANGUL SYLLABLE [A-Z]+(?:\.\.HANGUL SYLLABLE [A-Z]+)?/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }
  
  Benchmark("HTML") { benchmark in
    let re = #/<(\w*)\b[^>]*>(.*?)<\/\1>/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.matches(of: re))
    }
  }
  
  Benchmark("Literal/Search") { benchmark in
    let re = #/HANGUL CHOSEONG TIKEUT-MIEUM\.\.HANGUL CHOSEONG SSANGYEORINHIEUH/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }
  Benchmark("Literal/SearchNotFound") { benchmark in
    let re = #/magic_string_to_search_for/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("NotFound/Simple") { benchmark in
    let input = String(repeating: " ", count: 100_000)
    benchmark.startMeasurement()
    let re = #/a/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }
  Benchmark("NotFound/Anchored") { benchmark in
    let input = String(repeating: " ", count: 100_000)
    benchmark.startMeasurement()
    let re = #/^ +a/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.graphemeBreakData.matches(of: re))
    }
  }

  Benchmark("Emojis") { benchmark in
    let re = #/(😃|😀|😳|😲|😦|😊|🙊|😘|😏|😳|😒){2,5}/#
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedEmojis.matches(of: re))
    }
  }
  
  Benchmark("Addresses/IPv4") { benchmark in
    for _ in benchmark.scaledIterations {
      let c = TestData.ipv4Addresses
        .count(where: { $0.wholeMatch(of: ipv4) != nil })
      blackHole(c)
    }
  }
  Benchmark("Addresses/IPv6") { benchmark in
    for _ in benchmark.scaledIterations {
      let c = TestData.ipv6Addresses
        .count(where: { $0.wholeMatch(of: ipv6) != nil })
      blackHole(c)
    }
  }
  Benchmark("Addresses/MAC") { benchmark in
    for _ in benchmark.scaledIterations {
      let c = TestData.macAddresses
        .count(where: { $0.wholeMatch(of: macAddr) != nil })
      blackHole(c)
    }
  }


}
