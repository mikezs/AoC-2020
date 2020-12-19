import Foundation

public final class Day19: Day {
    private struct Rule {
        private struct Pair {
            let left: Int
            let right: Int?
            let farRight: Int?

            init(left: Int) {
                self.left = left
                self.right = nil
                self.farRight = nil
            }

            init(left: Int, right: Int) {
                self.left = left
                self.right = right
                self.farRight = nil
            }

            init(left: Int, right: Int, farRight: Int) {
                self.left = left
                self.right = right
                self.farRight = farRight
            }
        }

        private let left: Pair?
        private let right: Pair?
        private let letter: String?
        private let rule: Int?

        init(string: String) {
            if string.contains("\"") {
                left = nil
                right = nil
                letter = String(string[string.index(string.startIndex, offsetBy: 1)..<string.index(string.endIndex, offsetBy: -1)])
                rule = nil
            } else if string.contains(" ") {
                let ruleParts = string.components(separatedBy: " ")

                if string.contains("|") {
                    if ruleParts.count == 3 {
                        left = Pair(left: Int(ruleParts[0])!)
                        right = Pair(left: Int(ruleParts[2])!)
                    } else if ruleParts.count == 4 {
                        left = Pair(left: Int(ruleParts[0])!)
                        right = Pair(left: Int(ruleParts[2])!, right: Int(ruleParts[3])!)
                    } else if ruleParts.count == 5 {
                        left = Pair(left: Int(ruleParts[0])!, right: Int(ruleParts[1])!)
                        right = Pair(left: Int(ruleParts[3])!, right: Int(ruleParts[4])!)
                    } else {
                        left = Pair(left: Int(ruleParts[0])!, right: Int(ruleParts[1])!)
                        right = Pair(left: Int(ruleParts[3])!, right: Int(ruleParts[4])!, farRight: Int(ruleParts[5])!)
                    }
                    letter = nil
                } else {
                    left = Pair(left: Int(ruleParts[0])!, right: Int(ruleParts[1])!)
                    right = nil
                    letter = nil
                }

                rule = nil
            } else {
                left = nil
                right = nil
                letter = nil
                rule = Int(string)!
            }
        }

        func description(rules: [Int: Rule]) -> String {
            if let letter = letter {
                return letter
            } else if let rule = rule {
                return rules[rule]!.description(rules: rules)
            } else if let left = left {
                if let right = right {
                    let leftRight: String = rules[left.right ?? -1]?.description(rules: rules) ?? ""
                    let rightRight: String = rules[right.right ?? -1]?.description(rules: rules) ?? ""
                    let rightFarRight: String = rules[right.farRight ?? -1]?.description(rules: rules) ?? ""

                    return "((" +
                        rules[left.left]!.description(rules: rules) +
                        leftRight +
                        ")|(" +
                        rules[right.left]!.description(rules: rules) +
                        rightRight +
                        rightFarRight +
                        "))"
                } else {
                    let leftRight: String = rules[left.right ?? -1]?.description(rules: rules) ?? ""

                    return "(" +
                        rules[left.left]!.description(rules: rules) +
                        leftRight +
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
        let regex = "^"+rules[0]!.description(rules: rules)+"$"
        return messages.filter { !$0.matches(for: regex).isEmpty }.count
    }

    public func part2() -> Int {
        var newRules = rules

        newRules[8] = Rule(string: "42 | 1000")
        let end = 1003

        for index in 1000...end {
            let last: Int

            if index == end {
                last = 42
            } else {
                last = index + 1
            }

            newRules[index] = Rule(string: "42 | 42 \(last)")
        }

        newRules[11] = Rule(string: "42 31 | 42 2000 31")
        let elevenEnd = 2003

        for index in 2000...elevenEnd {
            if index == elevenEnd {
                newRules[index] = Rule(string: "42 31")
            } else {
                newRules[index] = Rule(string: "42 31 | 42 \(index + 1) 31")
            }
        }

        let regex = "^"+newRules[0]!.description(rules: newRules)+"$"
        return messages.filter { !$0.matches(for: regex).isEmpty }.count
    }
}

