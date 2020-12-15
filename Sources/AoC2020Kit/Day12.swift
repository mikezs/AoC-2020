import Foundation

public final class Day12: Day {
    enum Instruction: String {
        case left = "L"
        case right = "R"
        case north = "N"
        case east = "E"
        case south = "S"
        case west = "W"
        case forward = "F"
        case unknown
    }

    private let input: [(Instruction, Int)]

    public init(input: String) {
        self.input = input.trimmedLines.map {
            (Instruction(rawValue: String($0.prefix(1))) ?? .unknown,
             Int(String($0.suffix($0.count - 1)))!)
        }
    }

    public func part1() -> Int {
        var angle = 0
        var x = 0
        var y = 0

        for (instruction, value) in input {
            switch instruction {
            case .left:     angle = (angle + (360 - value)) % 360
            case .right:    angle = (angle + value) % 360
            case .north:    y -= value
            case .east:     x += value
            case .south:    y += value
            case .west:     x -= value
            case .forward:
                if angle == 0 {
                    x += value
                } else if angle == 90 {
                    y += value
                } else if angle == 180 {
                    x -= value
                } else if angle == 270 {
                    y -= value
                }
            case .unknown: return -1
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
            case .forward:
                shipE += value * waypointE
                shipN += value * waypointN
            case .north: waypointN += value
            case .east: waypointE += value
            case .south: waypointN -= value
            case .west: waypointE -= value
            case .left:
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
            case .right:
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
            case .unknown: return -1
            }
        }

        return abs(shipE) + abs(shipN)
    }
}
