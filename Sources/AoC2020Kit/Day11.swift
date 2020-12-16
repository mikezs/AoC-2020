import Foundation

public struct Seat: Equatable {
    public let occupied: Bool

    public init(occupied: Bool) {
        self.occupied = occupied
    }
}

public func == (lhs: Seat, rhs: Seat) -> Bool {
    return lhs.occupied == rhs.occupied
}

public final class Day11: Day {
    private enum Direction {
        case north
        case northEast
        case east
        case southEast
        case south
        case southWest
        case west
        case northWest
    }

    private let input: [[Seat?]]

    public init(input: String) {
        self.input = input.trimmedLines.map {
            var seats = [Seat?]()

            for char in $0 {
                if String(char) == "L" {
                    seats.append(Seat(occupied: false))
                } else {
                    seats.append(nil)
                }
            }

            return seats
        }
    }

    public func part1() -> Int {
        var lastIteration = input

        //Self.printableSeats(lastIteration).forEach { print($0) }

        while true {
            let nextIteration = iterate(seats: lastIteration)

            if nextIteration == lastIteration {
                return occupiedSeats(seats: lastIteration)
            }

            lastIteration = nextIteration

            //Self.printableSeats(lastIteration).forEach { print($0) }
        }
    }

    public static func printableSeats(_ seats: [[Seat?]]) -> [String] {
        seats.map { $0.reduce("", { $0 + ($1?.occupied == true ? "#" : $1?.occupied == false ? "L" : ".") }) }
    }

    public func iterate(seats: [[Seat?]]) -> [[Seat?]] {
        var iteration = seats

        for (y, row) in seats.enumerated() {
            for (x, seat) in row.enumerated() where seat != nil {
                var occupiedSeats = 0

                for i in -1...1 where (y + i >= 0) && (y + i < seats.count) {
                    for j in -1...1 where !(i == 0 && j == 0) && (x + j >= 0) && (x + j < row.count) {
                        let search = seats[y+i][x+j]

                        if search?.occupied == true {
                            occupiedSeats += 1
                        }
                    }
                }

                if seat?.occupied == false && occupiedSeats == 0 {
                    iteration[y][x] = Seat(occupied: true)
                } else if seat?.occupied == true && occupiedSeats >= 4 {
                    iteration[y][x] = Seat(occupied: false)
                }
            }
        }

        return iteration
    }

    public func occupiedSeats(seats: [[Seat?]]) -> Int {
        seats.map { $0.compactMap { $0 }.filter { $0.occupied }.count  }.reduce(0, +)
    }

    public func part2() -> Int {
        var lastIteration = input

        //Self.printableSeats(lastIteration).forEach { print($0) }

        while true {
            let nextIteration = self.iterateSight(seats: lastIteration)

            if nextIteration == lastIteration {
                return occupiedSeats(seats: lastIteration)
            }

            lastIteration = nextIteration

            //Self.printableSeats(lastIteration).forEach { print($0) }
        }
    }

    private func direction(_ j: Int, _ i: Int) -> Direction? {
        switch (j, i) {
        case (-1,-1): return .northWest
        case (-1,0): return .west
        case (-1,1): return .southWest
        case (0,-1): return .north
        case (0,1): return .south
        case (1,-1): return .northEast
        case (1,0): return .east
        case (1,1): return .southEast
        default: return nil
        }
    }

    public func iterateSight(seats: [[Seat?]]) -> [[Seat?]] {
        var iteration = seats

        for (y, row) in seats.enumerated() {
            for (x, seat) in row.enumerated() where seat != nil {
                var occupiedSeats = 0
                var foundAt: [Direction: Bool] = [
                    .north: false,
                    .northEast: false,
                    .east: false,
                    .southEast: false,
                    .south: false,
                    .southWest: false,
                    .west: false,
                    .northWest: false,
                ]

                for d in 1...seats.count {
                    for i in -1...1 where (y + i * d >= 0) && (y + i * d < seats.count) {
                        for j in -1...1 where !(i == 0 && j == 0) && (x + j * d >= 0) && (x + j * d < row.count) {
                            let direction = self.direction(j, i)!

                            if let found = foundAt[direction], found {
                                continue
                            }

                            if let searchSeat = seats[y+i*d][x+j*d] {
                                if searchSeat.occupied {
                                    occupiedSeats += 1
                                }

                                foundAt[direction] = true
                            }
                        }
                    }
                }

                if seat?.occupied == false && occupiedSeats == 0 {
                    iteration[y][x] = Seat(occupied: true)
                } else if seat?.occupied == true && occupiedSeats >= 5 {
                    iteration[y][x] = Seat(occupied: false)
                }
            }
        }

        return iteration
    }
}
