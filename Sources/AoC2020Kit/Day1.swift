import Foundation

public final class Day1: Day {
    let input: [Int]

    public init(input: String) {
        self.input = input.trimmedLines.map { Int($0)! }
    }

    public func part1() -> Int {
        for line1 in input {
            for line2 in input where line1 + line2 == 2020 {
                return line1 * line2
            }
        }

        return -1
    }

    public func part2() -> Int {
        for line1 in input {
            for line2 in input {
                for line3 in input where line1 + line2 + line3 == 2020 {
                    return line1 * line2 * line3
                }
            }
        }

        return -1
    }
}
