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

        input.forEach {
            switch $0.0 {
            case "L": angle = (angle + (360 - $0.1)) % 360
            case "R": angle = (angle + $0.1) % 360
            case "N": y -= $0.1
            case "E": x += $0.1
            case "S": y += $0.1
            case "W": x -= $0.1
            case "F":
                if angle == 0 { x += $0.1 }
                if angle == 90 { y += $0.1 }
                if angle == 180 { x -= $0.1 }
                if angle == 270 { y -= $0.1 }
            default: return
            }
        }

        return abs(x) + abs(y)
    }

    public func part2() -> Int {
        var waypointE = 10
        var waypointN = 1
        var shipE = 0
        var shipN = 0

        input.forEach {
            switch $0.0 {
            case "F":
                shipE += $0.1 * waypointE
                shipN += $0.1 * waypointN
            case "N": waypointN += $0.1
            case "E": waypointE += $0.1
            case "S": waypointN -= $0.1
            case "W": waypointE -= $0.1
            case "L":
                switch $0.1 {
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
                default: assertionFailure()
                }
            case "R":
                switch $0.1 {
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
                default: assertionFailure()
                }
            default: assertionFailure()
            }
        }

        return abs(shipE) + abs(shipN)
    }
}
