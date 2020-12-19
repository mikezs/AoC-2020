import Foundation

public final class Day19: Day {
    private struct Rule {
        private struct OrRule {
            let left: Int
            let right: Int
        }

        private let left: Int?
        private let middle: OrRule?
        private let right: Int?
        private let letter: String?

        init(string: String) {
            if string.contains("|") {
                let ruleParts = string.components(separatedBy: " ")
                left = Int(ruleParts[0])!
                middle = OrRule(left: Int(ruleParts[1])!, right: Int(ruleParts[3])!)
                right = Int(ruleParts[4])!
                letter = nil
            } else {
                left = nil
                middle = nil
                right = nil
                letter = String(string[1])
            }
        }

        func description(rules: [Int: Rule]) -> String {
            if let letter = letter {
                return letter
            } else if let left = left, let middle = middle, let right = right {
                let one: String = rules[left]!.description(rules: rules)
                let two: String = rules[middle.left]!.description(rules: rules)

                return "(" +
                    one +
                    "(" +
                    two +
                    "|" +
                    rules[middle.right]!.description(rules: rules) +
                    ")" +
                    rules[right]!.description(rules: rules) +
                    ")"
            }
            fatalError()
        }
    }

    private let rules: [Int: Rule]
    private let messages: [String]

    public init(input: String) {
        let parts = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
        rules = parts[0]
            .components(separatedBy: .newlines)
            .reduce([Int: Rule](), {
                let ruleParts = $1.components(separatedBy: ": ")
                let key = Int(ruleParts[0])!
                return $0.adding(key: key, value: Rule(string: ruleParts[1]))
            })
        messages = parts[1]
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        let regex = rules[0]?.description(rules: rules)
        return messages.count
    }

    public func part2() -> Int {
        0
    }
}

