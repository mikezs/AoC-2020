import Foundation

public final class Day10: Day {
    private let input: [Int]
    private var tribonachi = [0, 1, 1, 2, 4, 7]

    public init(input: String) {
        self.input = input.trimmedInts.sorted()
    }

    public func part1() -> Int {
        let differences = self.differences()
        return (differences[1] ?? 0) * (differences[3] ?? 0)
    }

    public func differences() -> [Int: Int] {
        // Initialise one at the start (0 jolts) and one at the end (always +3)
        var differences = [1: 1, 2: 0, 3: 1]

        for (index, adapter) in input.enumerated() where index < input.count - 1 {
            let difference = input[index+1] - adapter
            differences[difference]! += 1
        }

        return differences
    }

    public func part2() -> Int {
        permutations(for: input) +
            (input[1] <= 3 ? permutations(for: Array(input.suffix(from: 1))) : 0) +
            (input[2] <= 3 ? permutations(for: Array(input.suffix(from: 2))) : 0)
    }

    public func permutations(for array: [Int]) -> Int {
        var permutations = 1
        var currentCount = 1

        for (index, value) in array.enumerated() {
            if index < (array.count - 1), array[index + 1] - value == 1 {
                currentCount += 1
            } else {
                permutations *= tribonachi[currentCount]
                currentCount = 1
            }
        }

        return permutations
    }

    /*
    // Recursive attempt. Works, but will take a looooong time
    public func recursivePermutations(from index: Int) -> Int {
        var permutations = 0
        let currentValue = input[index]

        for step in 1...3 where index + step < input.count && input[index+step] - currentValue <= 3 {
            let subPermutations = self.recursivePermutations(from: index + step)

            if subPermutations == 0 {
                permutations += 1
            } else {
                permutations += subPermutations
            }
        }

        return permutations
    }
    */
}
