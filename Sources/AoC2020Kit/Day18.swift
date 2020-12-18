import Foundation

public final class Day18: Day {
    private let input: [String]

    public init(input: String) {
        self.input = input.trimmedLines
    }

    func result(for line: String, plusBindsTighter: Bool = false) throws -> Int {
        var current = line

        while true {
            if let newCurrent = try? current.using(regex: "\\(([^()]+)\\)", replaceWith: { matches in
                try! String(result(for: matches[0], plusBindsTighter: plusBindsTighter))
            }) {
                current = newCurrent
            } else {
                break
            }
        }

        if plusBindsTighter {
            while true {
                if let newCurrent = try? current.using(regex: "([0-9]+)([+])([0-9]+)", replaceWith: { matches in
                    return String(Int(matches[0])! + Int(matches[2])!)
                }) {
                    current = newCurrent
                } else {
                    break
                }
            }

            while true {
                if let newCurrent = try? current.using(regex: "([0-9]+)([*])([0-9]+)", replaceWith: { matches in
                    return String(Int(matches[0])! * Int(matches[2])!)
                }) {
                    current = newCurrent
                } else {
                    break
                }
            }
        } else {
            while true {
                if let newCurrent = try? current.using(regex: "([0-9]+)([+*])([0-9]+)", replaceWith: { matches in
                    if matches[1] == "+" { return String(Int(matches[0])! + Int(matches[2])!) }
                    else { return String(Int(matches[0])! * Int(matches[2])!) }
                }) {
                    current = newCurrent
                } else {
                    break
                }
            }
        }

        return Int(current)!
    }

    public func part1() -> Int {
        input.map{ $0.replacingOccurrences(of: " ", with: "") }.compactMap { try? result(for: $0) }.reduce(0, +)
    }

    public func part2() -> Int {
        input.map{ $0.replacingOccurrences(of: " ", with: "") }.compactMap { try? result(for: $0, plusBindsTighter: true) }.reduce(0, +)
    }
}

