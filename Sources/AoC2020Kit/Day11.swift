import Foundation

public struct Seat: Equatable {
    let occupied: Bool
}

public func ==(lhs: Seat, rhs: Seat) -> Bool {
    return lhs.occupied == rhs.occupied
}

public final class Day11: Day {
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

        //printSeats(lastIteration)

        while true {
            let nextIteration = iterate(seats: lastIteration)

            if nextIteration == lastIteration {
                return occupiedSeats(seats: lastIteration)
            }

            lastIteration = nextIteration

            //printSeats(lastIteration)
        }
    }

    public func printSeats(_ seats: [[Seat?]]) {
        seats.forEach { print($0.reduce("", { $0 + ($1?.occupied == true ? "#" : $1?.occupied == false ? "L" : ".") })) }
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

        //printSeats(lastIteration)

        while true {
            let nextIteration = self.iterateSight(seats: lastIteration)

            if nextIteration == lastIteration {
                return occupiedSeats(seats: lastIteration)
            }

            lastIteration = nextIteration

            //printSeats(lastIteration)
        }
    }

    public func iterateSight(seats: [[Seat?]]) -> [[Seat?]] {
        var iteration = seats

        for (y, row) in seats.enumerated() {
            for (x, seat) in row.enumerated() where seat != nil {
                var occupiedSeats = 0
                var foundAt = [
                    "N": false,
                    "NE": false,
                    "E": false,
                    "SE": false,
                    "S": false,
                    "SW": false,
                    "W": false,
                    "NW": false,
                ]

                for d in 1...seats.count {
                    for i in -1...1 where (y + i * d >= 0) && (y + i * d < seats.count) {
                        for j in -1...1 where !(i == 0 && j == 0) && (x + j * d >= 0) && (x + j * d < row.count) {
                            let direction: String

                            switch (j, i) {
                            case (-1,-1): direction = "NW"
                            case (-1,0): direction = "W"
                            case (-1,1): direction = "SW"
                            case (0,-1): direction = "N"
                            case (0,1): direction = "S"
                            case (1,-1): direction = "NE"
                            case (1,0): direction = "E"
                            case (1,1): direction = "SE"
                            default: continue
                            }

                            if foundAt[direction] == true {
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
