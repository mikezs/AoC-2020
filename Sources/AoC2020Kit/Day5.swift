import Foundation

public final class Day5: Day {
    private let input: [Int]
    
    public init(input: String) {
        self.input = input.trimmedLines.map { Day5.seatID(instructions: $0) }
    }

    public func part1() -> Int {
        input.reduce(0, { max($0, $1) })
    }

    public func part2() -> Int {
        let sortedInput = input.sorted()
        var previous = sortedInput.first! - 1
        
        for number in input.sorted() {
            if number != previous + 1 {
                return previous + 1
            }
            
            previous = number
        }
        
        return 0
    }
    
    public static func seatID(instructions: String) -> Int {
        var xLower = 0
        var xUpper = 127
        var yLower = 0
        var yUpper = 7
        
        for char in instructions.prefix(7) {
            switch char {
            case "F":
                xUpper = xUpper - ((xUpper - xLower + 1) / 2)
            case "B":
                xLower = xLower + ((xUpper - xLower + 1) / 2)
            default:
                print("Invalid front/back instruction \(char)")
                return -1
            }
            
            print("\(char) keeps rows \(xLower) through \(xUpper)")
        }
        
        assert(xLower == xUpper)
        
        for char in instructions.suffix(3) {
            switch char {
            case "L":
                yUpper = yUpper - ((yUpper - yLower + 1) / 2)
            case "R":
                yLower = yLower + ((yUpper - yLower + 1) / 2)
            default:
                print("Invalid left/right instruction \(char)")
                return -1
            }
        }
        
        assert(yLower == yUpper)
        
        return xLower * 8 + yLower
    }
}
