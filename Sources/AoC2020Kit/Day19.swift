import Foundation

protocol RuleValue {}
extension Int: RuleValue {}
extension String: RuleValue {}

public final class Day19: Day {
    private struct Rule {
        private struct OrRule {
            let left: RuleValue
            let right: RuleValue
        }

        private let left: RuleValue
        private let middle: OrRule
        private let right: RuleValue

        init(string: String) {
            left = 0
            middle = OrRule(left: 0, right: 0)
            right = 0
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
                
                $0.adding(key: $1.1)
            })
        messages = parts[1]
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        0
    }

    public func part2() -> Int {
        0
    }
}

