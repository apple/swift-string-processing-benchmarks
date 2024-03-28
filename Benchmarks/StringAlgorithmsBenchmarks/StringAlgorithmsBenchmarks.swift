import Benchmark
import _StringProcessing
import TestData

let benchmarks = {
  
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
  
  Benchmark("split/Devanagari") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.taggedDevanagari.firstRange(of: "खो"))
    }
  }
  
  Benchmark("split/HTML") { benchmark in
    for _ in benchmark.scaledIterations {
      blackHole(TestData.swiftOrgHTML.firstRange(of: "/assets/javascripts"))
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
}
