import Foundation

public final class Day15: Day {
    typealias Turn = Int
    private let input: [Int]
    private var target: Turn?

    public convenience init(input: String) {
        self.init(input: input, target: nil)
    }

    public init(input: String, target: Int?) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ",")
            .compactMap { Int($0) }
        self.target = target
    }

    private func run(target: Int) -> Int {
        var turn: Turn = 1
        var lastSeen = [Int: Turn]()
        var next: (Int, Turn)?
        var lastValue = input.last!

        input.enumerated().forEach { (index, number) in
            if index == input.count - 1 {
                next = (number, turn)
            } else {
                lastSeen[number] = turn
            }

            turn += 1
        }

        while turn <= target {
            let delayedApply = next

            if let oldLastSeen = lastSeen[lastValue] {
                lastValue = turn - oldLastSeen - 1
            } else {
                lastValue = 0
            }

            next = (lastValue, turn)

            lastSeen[delayedApply!.0] = delayedApply!.1

            turn += 1
        }

        return lastValue
    }

    public func part1() -> Int {
        run(target: self.target ?? 2020)
    }

    public func part2() -> Int {
        run(target: self.target ?? 30000000)
    }
}
