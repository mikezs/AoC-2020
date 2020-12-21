import Foundation

public final class Day20: Day {
    public final class Tile {
        enum Side {
            case left
            case right
            case top
            case bottom
        }

        let number: Int
        private(set) var leftConnection: Tile?
        private(set) var rightConnection: Tile?
        private(set) var topConnection: Tile?
        private(set) var bottomConnection: Tile?
        let contents: [[Bool]]
        let sides: [Side: [Bool]]

        init(_ string: String) {
            let lines = string.components(separatedBy: .newlines)

            number = Int(lines[0].matches(for: "Tile ([0-9]+):")[0][0])!

            var contents = [[Bool]]()

            for index in 1..<lines.count {
                contents.append(lines[index].reduce([Bool](), { $0 + [$1 == "#"] }))
            }

            self.contents = contents

            var sides = [Side: [Bool]]()
            sides[.left] = contents.reduce([Bool](), { $0 + [$1[0]] })
            sides[.right] = contents.reduce([Bool](), { $0 + [$1[$1.count - 1]] })
            sides[.top] = contents[0]
            sides[.bottom] = contents[contents.count - 1]
            self.sides = sides
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
//        let sideLength = Int(Double(tiles.count).squareRoot())
//        var sides = [Int: (Tile.Side, Tile)]()
//
//        for tile in tiles {
//            for (side, values) in tile.sides {
//                //sides[]
//            }
//        }
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

