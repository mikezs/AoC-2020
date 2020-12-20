import Foundation

public final class Day20: Day {
    public final class Tile {
        let number: Int
        private(set) var leftConnection: Tile?
        private(set) var rightConnection: Tile?
        private(set) var topConnection: Tile?
        private(set) var bottomConnection: Tile?

        init(_ string: String) {
            let lines = string.components(separatedBy: .newlines)

            number = Int(lines[0].matches(for: "Tile ([0-9]+):")[0][0])!
        }

        public var connections: [Tile] {
            [leftConnection, rightConnection, topConnection, bottomConnection]
                .compactMap { $0 }
        }
    }

    private let input: [Tile]

    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map { Tile($0) }
    }

    private func connect(tiles: [Tile]) {

    }

    public func part1() -> Int {
        connect(tiles: input)

        return input
            .filter { $0.connections.count == 2 }
            .map { $0.number }
            .reduce(1, *)
    }

    public func part2() -> Int {
        0
    }
}

