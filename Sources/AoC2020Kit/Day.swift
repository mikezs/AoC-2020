import Foundation

public protocol Day {
    init(input: String)
    func part1() -> Int
    func part2() -> Int
}

extension String {
    var trimmedLines: [String] { trimmingCharacters(in: .newlines).components(separatedBy: .newlines) }
}

extension String {
    func matches(for regexString: String) -> [[String]] {
        let regex = NSRegularExpression(regexString)
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

        var stringMatches = [[String]]()

        for match in matches {
            var subMatches = [String]()

            for rangeNumber in 1 ..< match.numberOfRanges {
                let range = match.range(at: rangeNumber)

                if let stringRange = Range(range, in: self) {
                    subMatches.append(String(self[stringRange]))
                }
            }

            stringMatches.append(subMatches)
        }

        return stringMatches
    }
}

extension Dictionary {
    func adding(key: Key, value: Value) -> [Key: Value] {
        var copy = self
        copy[key] = value
        return copy
    }
}

// https://stackoverflow.com/a/24144365
extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

// https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
