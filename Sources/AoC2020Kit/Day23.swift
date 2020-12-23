import Foundation

public final class Day23: Day {
    public typealias CupValue = Int
    public typealias CupIndex = Int

    private let input: [CupValue]

    public init(input: String) {
        self.input = input.trimmedLines[0].compactMap { Int(String($0)) }
    }

    public static func play(with cups: inout [CupValue], moves: Int) {
        var currentCupIndex = 0
        var currentCupValue: CupValue
        var destinationCupValue: CupValue?

        for move in 0 ..< moves {
            print("move \(move)")
            currentCupValue = cups[currentCupIndex]

            // Re-order array so current cup is 0th
            while cups.first != currentCupValue {
                cups.append(cups.removeFirst())
            }

            //print("cups: \(cups.map { String($0) }.joined(separator: " "))")

            // Pick 3 cups, remove cups from array
            var pickedUp = [CupValue]()

            for _ in 0 ..< 3 {
                pickedUp.append(cups.remove(at: 1))
            }

            //print("pick up: \(pickedUp.map { String($0) }.joined(separator: " "))")

            // Pick destination cup index
            destinationCupValue = nil
            var destinationCupValueTest = currentCupValue - 1

            while destinationCupValue == nil {
                if cups.contains(destinationCupValueTest) {
                    destinationCupValue = destinationCupValueTest
                    break
                }

                destinationCupValueTest -= 1

                if destinationCupValueTest < 1 {
                    destinationCupValueTest = 9
                }
            }

            //print("destination: \(String(destinationCupValue!))")

            // Re-order array so destination cup is 0th
            while cups.first != destinationCupValue {
                cups.append(cups.removeFirst())
            }

            // Insert cups after destination cup
            cups.insert(contentsOf: pickedUp, at: 1)

            // Set new current cup index
            currentCupIndex = (cups.firstIndex(of: currentCupValue)! + 1) % cups.count
        }
    }

    public func part1() -> Int {
        part1(moves: 100)
    }

    public func part1(moves: Int) -> Int {
        var cups = input

        Day23.play(with: &cups, moves: moves)

        let indexOfOne = cups.firstIndex(of: 1)!
        var result = ""

        for index in 1 ..< cups.count {
            result += String(cups[(indexOfOne + index) % cups.count])
        }

        return Int(result)!
    }

    public func part2() -> Int {
        var cups = input

        while cups.count < 1000000 {
            cups.append(cups.count + 1)
        }

        Day23.play(with: &cups, moves: 10000000)

        let indexOfOne = cups.firstIndex(of: 1)!

        return cups[(indexOfOne + 1) % cups.count] * cups[(indexOfOne + 2) % cups.count]
    }
}

