import Foundation

public final class Day9: Day {
    private let input: [Int]
    private let preambleLength: Int

    public convenience init(input: String) {
        self.init(input: input, preambleLength: 25)
    }

    public init(input: String, preambleLength: Int = 25) {
        self.input = input.trimmedLines.map { Int($0)! }
        self.preambleLength = preambleLength
    }

    init(input: [Int], preambleLength: Int = 25) {
        self.input = input
        self.preambleLength = preambleLength
    }

    static func parse(string: String, preambleLength: Int) -> Day9 {
        return Day9(input: string.trimmedLines.map { Int($0)! }, preambleLength: preambleLength)
    }

    public func part1() -> Int {
        var position = preambleLength

        while position != input.count {
            let toFind = input[position]
            let currentSlice = input[(position - preambleLength)...position]
            var found = false

            currentSlice.forEach { number1 in
                currentSlice.forEach { number2 in
                    if number1 != number2 && number1 + number2 == toFind {
                        found = true
                    }
                }
            }

            if !found {
                return toFind
            }

            position += 1
        }

        return -1
    }

    public func part2() -> Int {
        let find = 20874512
        var currentSliceWidth = 2

        while currentSliceWidth < input.count {
            for index in 0..<input.count - currentSliceWidth {
                let slice = input[index...(index+currentSliceWidth-1)]
                if find == slice.reduce(0, +) {
                    return (slice.min() ?? 0) + (slice.max() ?? 0)
                }
            }

            currentSliceWidth += 1
        }

        return 0
    }
}
