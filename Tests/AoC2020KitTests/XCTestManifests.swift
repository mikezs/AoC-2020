import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AoC_2020Tests.allTests)
    ]
}
#endif
