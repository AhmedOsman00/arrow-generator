import XCTest

@testable import ArrowGeneratorCore

class DependencyRegistrationGeneratorTests: XCTestCase {
  func testPackageMode_WhenPackageSourcesPathMissing_ThrowsValidationError() {
    var generator = DependencyRegistrationGenerator()
    generator.verbose = false
    generator.isPackage = true
    generator.packageSourcesPaths = []
    XCTAssertThrowsError(try generator.run()) { error in
      XCTAssertTrue(error is DependencyRegistrationGenerator.ValidationError)
      XCTAssertEqual(error.localizedDescription, "Argument: --package-path is required.")
    }
  }

  func testXcodeMode_WhenTargetNameMissing_ThrowsValidationError() {
    var generator = DependencyRegistrationGenerator()
    generator.verbose = false
    generator.isPackage = false
    generator.targetName = nil

    XCTAssertThrowsError(try generator.run()) { error in
      XCTAssertTrue(error is DependencyRegistrationGenerator.ValidationError)
      XCTAssertEqual(error.localizedDescription, "Argument: --target-name is required.")
    }
  }

  func testXcodeMode_WhenDepsExtPathMissing_ThrowsValidationError() {
    var generator = DependencyRegistrationGenerator()
    generator.verbose = false
    generator.isPackage = false
    generator.targetName = "Main"
    generator.depsExtPath = nil

    XCTAssertThrowsError(try generator.run()) { error in
      XCTAssertTrue(error is DependencyRegistrationGenerator.ValidationError)
      XCTAssertEqual(error.localizedDescription, "Argument: --ext-path is required.")
    }
  }
}
