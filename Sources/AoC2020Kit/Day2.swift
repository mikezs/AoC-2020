import Foundation

public final class Day2: Day {
    private let input: [Password]
    
    private struct Password {
        let input1: Int
        let input2: Int
        let char: String
        let password: String
        
        var isValidPart1: Bool {
            let count = password.components(separatedBy: char).count - 1
            return count >= input1 && count <= input2
        }
        
        var isValidPart2: Bool {
            let char1 = String(password[input1-1]) == char
            let char2 = String(password[input2-1]) == char
            
            return (char1 && !char2) || (!char1 && char2)
        }
        
        static func factory(input: String) -> Password {
            let parts = input.components(separatedBy: ": ")
            let password = parts[1]
            let parts2 = parts[0].components(separatedBy: " ")
            let char = parts2[1]
            let parts3 = parts2[0].components(separatedBy: "-")
            let input1 = Int(parts3[0])!
            let input2 = Int(parts3[1])!
            
            return Password(input1: input1, input2: input2, char: char, password: password)
        }
    }

    public init(input: String) {
        self.input = input.trimmedLines.map { Password.factory(input: $0) }
    }

    public func part1() -> Int {
        input.filter { $0.isValidPart1 }.count
    }

    public func part2() -> Int {
        input.filter { $0.isValidPart2 }.count
    }
}
