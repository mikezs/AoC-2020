import Foundation

public final class Day13: Day {
    private let time: Int
    private let busses: [Int]

    public init(input: String) {
        let lines = input.trimmedLines

        if lines.count == 1 {
            time = -1
            busses = lines[0].split(separator: ",").map { Int($0) ?? -1 }
        } else {
            time = Int(lines[0])!
            busses = lines[1].split(separator: ",").map { Int($0) ?? -1}
        }
    }

    public func part1() -> Int {
        var busID = -1
        var lowestTime = time

        busses.filter { $0 != -1 }.forEach {
            let busWait = $0 - (time % $0)

            if busWait < lowestTime {
                busID = $0
                lowestTime = busWait
            }
        }

        return busID * lowestTime
    }

    public func part2() -> Int {
        let max = busses.sorted().last!
        let maxIndex = busses.firstIndex(of: max)!
        var currentOffset = max % 1_000_000_000_000

        while true {
            let t = currentOffset - maxIndex

            for (index, bus) in busses.enumerated() where bus != -1 {
                if (t + index) % bus == 0 {
                    if index == busses.count - 1 {
                        return t
                    }
                } else {
                    break
                }
            }

            currentOffset += max
        }
    }
}
