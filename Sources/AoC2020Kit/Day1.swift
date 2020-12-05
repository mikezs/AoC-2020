import Foundation

public final class Day1: Day {
    let input: [Int]

    public init(input: String) {
        self.input = input.trimmedLines.map { Int($0)! }
    }

    public func part1() -> Int {
        for l1 in input {
            for l2 in input {
                if l1+l2 == 2020 {
                    return l1*l2
                }
            }
        }
        
        return -1
    }

    public func part2() -> Int {
        for l1 in input {
            for l2 in input {
                for l3 in input {
                    if l1+l2+l3 == 2020 {
                        return l1*l2*l3
                    }
                }
            }
        }
        
        return -1
    }
}
