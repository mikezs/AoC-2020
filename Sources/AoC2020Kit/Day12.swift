import Foundation

public final class Day12: Day {
    private let input: [(String, Int)]

    public init(input: String) {
        self.input = input.trimmedLines.map { (String($0.prefix(1)), Int(String($0.suffix($0.count - 1)))!) }
    }

    public func part1() -> Int {
        var angle = 0
        var x = 0
        var y = 0

        for (instruction, value) in input {
            switch instruction {
            case "L": angle = (angle + (360 - value)) % 360
            case "R": angle = (angle + value) % 360
            case "N": y -= value
            case "E": x += value
            case "S": y += value
            case "W": x -= value
            case "F":
                if angle == 0 { x += value }
                if angle == 90 { y += value }
                if angle == 180 { x -= value }
                if angle == 270 { y -= value }
            default: return -1
            }
        }

        return abs(x) + abs(y)
    }

    public func part2() -> Int {
        var waypointE = 10
        var waypointN = 1
        var shipE = 0
        var shipN = 0

        for (instruction, value) in input {
            switch instruction {
            case "F":
                shipE += value * waypointE
                shipN += value * waypointN
            case "N": waypointN += value
            case "E": waypointE += value
            case "S": waypointN -= value
            case "W": waypointE -= value
            case "L":
                switch value {
                case 90:
                    let oldE = waypointE
                    waypointE = -waypointN
                    waypointN = oldE
                case 180:
                    waypointE *= -1
                    waypointN *= -1
                case 270:
                    let oldE = waypointE
                    waypointE = waypointN
                    waypointN = -oldE
                default: return -1
                }
            case "R":
                switch value {
                case 90:
                    let oldE = waypointE
                    waypointE = waypointN
                    waypointN = -oldE
                case 180:
                    waypointE *= -1
                    waypointN *= -1
                case 270:
                    let oldE = waypointE
                    waypointE = -waypointN
                    waypointN = oldE
                default: return -1
                }
            default: return -1
            }
        }

        return abs(shipE) + abs(shipN)
    }
}
