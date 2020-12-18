import Foundation

public final class Day18: Day {
    private let input: [String]
    let digits = CharacterSet(charactersIn: "0123456789")

    public init(input: String) {
        self.input = input.trimmedLines
    }

    func result(for line: String) throws -> Int {
        var current = line
        var regularExpression = try NSRegularExpression(pattern: "\\(([^()]+)\\)")
        var match = regularExpression
            .firstMatch(in: current,
                        options: [],
                        range: NSRange(location: 0,
                                       length: current.utf16.count))

        while match != nil {
            guard match?.numberOfRanges == 2 else { fatalError() }

            let range = Range(match!.range, in: current)
            let innerRange = Range(match!.range(at: 1), in: current)
            let innerText = String(current[innerRange!])
            let innerResult = try result(for: innerText)

            current = current.replacingCharacters(in: range!, with: String(innerResult))

            match = regularExpression
                .firstMatch(in: current,
                            options: [],
                            range: NSRange(location: 0,
                                           length: current.utf16.count))
        }

        regularExpression = try NSRegularExpression(pattern: "([0-9]+)([+*])([0-9]+)")
        match = regularExpression
            .firstMatch(in: current,
                        options: [],
                        range: NSRange(location: 0,
                                       length: current.utf16.count))

        while match != nil {
            guard match?.numberOfRanges == 4 else { fatalError() }

            let range = Range(match!.range, in: current)
            let left = Int(String(current[Range(match!.range(at: 1), in: current)!]))!
            let oper = String(current[Range(match!.range(at: 2), in: current)!])
            let right = Int(String(current[Range(match!.range(at: 3), in: current)!]))!

            var result = 0

            if oper == "+" {
                result = left + right
            } else if oper == "*" {
                result = left * right
            } else {
                fatalError()
            }

            current = current.replacingCharacters(in: range!, with: String(result))

            match = regularExpression
                .firstMatch(in: current,
                            options: [],
                            range: NSRange(location: 0,
                                           length: current.utf16.count))
        }

        return Int(current)!
    }

    func result2(for line: String) throws -> Int {
        var current = line
        var regularExpression = try NSRegularExpression(pattern: "\\(([^()]+)\\)")
        var match = regularExpression
           .firstMatch(in: current,
                       options: [],
                       range: NSRange(location: 0,
                                      length: current.utf16.count))

        while match != nil {
           guard match?.numberOfRanges == 2 else { fatalError() }

           let range = Range(match!.range, in: current)
           let innerRange = Range(match!.range(at: 1), in: current)
           let innerText = String(current[innerRange!])
           let innerResult = try result2(for: innerText)

           current = current.replacingCharacters(in: range!, with: String(innerResult))

           match = regularExpression
               .firstMatch(in: current,
                           options: [],
                           range: NSRange(location: 0,
                                          length: current.utf16.count))
        }

        regularExpression = try NSRegularExpression(pattern: "([0-9]+)([+])([0-9]+)")
        match = regularExpression
           .firstMatch(in: current,
                       options: [],
                       range: NSRange(location: 0,
                                      length: current.utf16.count))

        while match != nil {
           guard match?.numberOfRanges == 4 else { fatalError() }

           let range = Range(match!.range, in: current)
           let left = Int(String(current[Range(match!.range(at: 1), in: current)!]))!
           let oper = String(current[Range(match!.range(at: 2), in: current)!])
           let right = Int(String(current[Range(match!.range(at: 3), in: current)!]))!

           var result = 0

           if oper == "+" {
               result = left + right
           } else {
               fatalError()
           }

           current = current.replacingCharacters(in: range!, with: String(result))

           match = regularExpression
               .firstMatch(in: current,
                           options: [],
                           range: NSRange(location: 0,
                                          length: current.utf16.count))
        }

        regularExpression = try NSRegularExpression(pattern: "([0-9]+)([*])([0-9]+)")
        match = regularExpression
            .firstMatch(in: current,
                        options: [],
                        range: NSRange(location: 0,
                                       length: current.utf16.count))

        while match != nil {
            guard match?.numberOfRanges == 4 else { fatalError() }

            let range = Range(match!.range, in: current)
            let left = Int(String(current[Range(match!.range(at: 1), in: current)!]))!
            let oper = String(current[Range(match!.range(at: 2), in: current)!])
            let right = Int(String(current[Range(match!.range(at: 3), in: current)!]))!

            var result = 0

            if oper == "*" {
                result = left * right
            } else {
                fatalError()
            }

            current = current.replacingCharacters(in: range!, with: String(result))

            match = regularExpression
                .firstMatch(in: current,
                            options: [],
                            range: NSRange(location: 0,
                                           length: current.utf16.count))
        }

       return Int(current)!
   }

    public func part1() -> Int {
        input.map{ $0.replacingOccurrences(of: " ", with: "") }.compactMap { try? result(for: $0) }.reduce(0, +)
    }

    public func part2() -> Int {
        input.map{ $0.replacingOccurrences(of: " ", with: "") }.compactMap { try? result2(for: $0) }.reduce(0, +)
    }
}

