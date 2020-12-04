import Foundation

public final class Day4: Day {
    private var input = [[String: String]]()

    public init(input: String) {
        self.input = input.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n").map {
            let $0.components(separatedBy: " \n").map {let parts = $0.components(separatedBy: ":") }
        }
    }

    public func part1() -> Int {
        return 0
    }

    public func part2() -> Int {
        return 0
    }
}
