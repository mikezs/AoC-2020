import Foundation

public final class Day10: Day {
    private let input: [Int]

    public init(input: String) {
        self.input = input.trimmedLines.map { Int($0)! }.sorted()
    }

    public func part1() -> Int {
        let differences = self.differences()
        return (differences[1] ?? 0) * (differences[3] ?? 0)
    }

    public func part2() -> Int {
        0
    }

    public func differences() -> [Int: Int] {
        var differences = [1: 0, 2: 0, 3: 0]

        differences[input[0]]! += 1

        for (index, adapter) in input.enumerated() {
            if index == input.count - 1 {
                differences[3]! += 1
                return differences
            }

            let difference = input[index+1] - adapter

            if difference > 0 && difference <= 3 {
                differences[difference]! += 1
            } else {
                return differences
            }
        }

        return differences
    }
}
