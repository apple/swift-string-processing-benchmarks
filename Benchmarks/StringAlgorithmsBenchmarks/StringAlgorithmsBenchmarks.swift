import Benchmark
import _StringProcessing
import TestData

let benchmarks = {
  Benchmark("firstRange/Devanagari-short") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedDevanagari.firstRange(of: "यब"))
    }
  }
  
  Benchmark("firstRange/Devanagari") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedDevanagari.firstRange(of: "यबऋॉलफ़"))
    }
  }
  
  Benchmark("firstRange/HTML") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.firstRange(of: "/assets/javascripts/application.js"))
    }
  }

  Benchmark("firstRange/many-small") { benchmark in
    for _ in benchmark.scaledIterations {
      for ipAddress in TestData.ipv4Addresses {
        blackHole(ipAddress.firstRange(of: "121"))
      }
    }
  }

  Benchmark("ranges/Devanagari") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedDevanagari.ranges(of: "खो"))
    }
  }
  
  Benchmark("ranges/HTML") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.ranges(of: "/assets/javascripts"))
    }
  }
  
  Benchmark("ranges/HTML-many") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.ranges(of: "section"))
    }
  }

  Benchmark("split/Devanagari") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedDevanagari.split(separator: "खो" as String))
    }
  }
  
  Benchmark("split/HTML") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.split(separator: "/assets/javascripts"))
    }
  }
  
  Benchmark("split/HTML-many") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.split(separator: "section"))
    }
  }

  Benchmark("replacing/Devanagari") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedDevanagari.replacing("खो", with: "-"))
    }
  }
  
  Benchmark("replacing/HTML") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.replacing("/assets/javascripts", with: "-"))
    }
  }
  Benchmark("replacing/HTML-many") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.replacing("section", with: "-"))
    }
  }
  Benchmark("replacing/HTML-many-small") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.replacing("sec", with: "-"))
    }
  }
}
