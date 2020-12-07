import Foundation

public final class Day3: Day {
    private let input: [[Bool]]

    public init(input: String) {
        self.input = input.trimmedLines.map {
            var array = [Bool]()

            for char in $0 {
                array.append(char == "#")
            }

            return array
        }
    }

    public func part1() -> Int {
        var trees = 0
        var horizontal = 0

        for line in input {
            if line[horizontal] {
                trees += 1
            }

            horizontal += 3
            horizontal %= input[0].count
        }

        return trees
    }

    public func part2() -> Int {
        return
            treesMoving(right: 1, down: 1) *
            treesMoving(right: 3, down: 1) *
            treesMoving(right: 5, down: 1) *
            treesMoving(right: 7, down: 1) *
            treesMoving(right: 1, down: 2)
    }

    private func treesMoving(right: Int, down: Int) -> Int {
        var trees = 0
        var horizontal = 0
        var vertical = 0

        while vertical < input.count {
            if input[vertical][horizontal] {
                trees += 1
            }

            horizontal += right
            horizontal %= input[0].count
            vertical += down
        }

        return trees
    }
}
