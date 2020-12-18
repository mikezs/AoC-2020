import Foundation

public protocol Day {
    init(input: String)
    func part1() -> Int
    func part2() -> Int
}

extension String {
    var trimmedLines: [String] { trimmingCharacters(in: .newlines).components(separatedBy: .newlines) }
    var trimmedInts: [Int] { trimmedLines.compactMap { Int($0) } }
}

extension String {
    enum Error: Swift.Error {
        case noMatches
    }

    func using(regex: String, replaceWith: ([String]) -> String) throws -> String {
        let wholeString = NSRange(location: 0, length: self.utf16.count)
        let match = try NSRegularExpression(pattern: regex)
            .firstMatch(in: self, options: [], range: wholeString)

        if let match = match, let range = Range(match.range, in: self) {
            var matches = [String]()

            for rangeNumber in 1 ..< match.numberOfRanges {
                let range = match.range(at: rangeNumber)

                if let stringRange = Range(range, in: self) {
                    matches.append(String(self[stringRange]))
                }
            }

            return self.replacingCharacters(in: range, with: replaceWith(matches))
        } else {
            throw Error.noMatches
        }
    }

    func matches(for regexString: String) -> [[String]] {
        let regex = try? NSRegularExpression(pattern: regexString)
        assert(regex != nil, "Invalid regex")
        let matches = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

        var stringMatches = [[String]]()

        matches?.forEach { match in
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
}

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
