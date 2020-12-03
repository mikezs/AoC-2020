import Foundation

public final class Day3 {
    let input: [[Bool]]

    public init(input: String) {
        self.input = input.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map {
            var array = [Bool]()
            for char in $0 { array.append(char == "#") }
            return array
        }
    }

    public func part1() -> Int {
        var trees = 0
        var x = 0

        for line in input {
            if line[x] {
                trees += 1
            }

            x += 3
            x = x % input[0].count
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
        var x = 0
        var y = 0

        while y < input.count {
            if input[y][x] {
                trees += 1
            }

            x += right
            x = x % input[0].count
            y += down
        }

        return trees
    }
}
