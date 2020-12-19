import Foundation

public final class Day19: Day {
    private struct Rule {
        private struct Pair {
            let left: Int
            let right: Int
        }

        private let left: Pair?
        private let right: Pair?
        private let letter: String?

        init(string: String) {
            if string.contains("\"") {
                left = nil
                right = nil
                letter = String(string[1])
            } else {
                let ruleParts = string.components(separatedBy: " ")

                if string.contains("|") {
                    left = Pair(left: Int(ruleParts[0])!, right: Int(ruleParts[1])!)
                    right = Pair(left: Int(ruleParts[3])!, right: Int(ruleParts[4])!)
                    letter = nil
                } else {
                    left = Pair(left: Int(ruleParts[0])!, right: Int(ruleParts[1])!)
                    right = nil
                    letter = nil
                }
            }
        }

        func description(rules: [Int: Rule]) -> String {
            if let letter = letter {
                return letter
            } else if let left = left {
                if let right = right {
                    return "(" +
                        rules[left.left]!.description(rules: rules) +
                        rules[left.right]!.description(rules: rules) +
                        "|" +
                        rules[right.left]!.description(rules: rules) +
                        rules[right.right]!.description(rules: rules) +
                        ")"
                } else {
                    return "(" +
                        rules[left.left]!.description(rules: rules) +
                        rules[left.right]!.description(rules: rules) +
                        ")"
                }
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
        let regex = rules[0]!.description(rules: rules)
        print(regex)
        return messages.filter { !$0.matches(for: regex).isEmpty }.count
    }

    public func part2() -> Int {
        0
    }
}

