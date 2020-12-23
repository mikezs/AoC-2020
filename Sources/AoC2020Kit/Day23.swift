import Foundation

public final class Day23: Day {
    typealias CupValue = Int
    typealias CupIndex = Int

    private let input: [CupValue]

    public init(input: String) {
        self.input = input.trimmedLines[0].compactMap { Int(String($0)) }
    }

    public func part1() -> Int {
        part1(moves: 100)
    }

    public func part1(moves: Int) -> Int {
        var cups = input
        var currentCupIndex = 0
        var currentCupValue: CupValue
        var destinationCupValue: CupValue?

        for _ in 0 ..< moves {
            currentCupValue = cups[currentCupIndex]

            // Re-order array so current cup is 0th
            while cups.first != currentCupValue {
                cups.append(cups.removeFirst())
            }

            // Pick 3 cups, remove cups from array
            var pickedUp = [CupValue]()

            for _ in 0 ..< 3 {
                pickedUp.append(cups.remove(at: 1))
            }

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

            // Re-order array so destination cup is 0th
            while cups.first != currentCupValue {
                cups.append(cups.removeFirst())
            }

            // Insert cups after destination cup
            cups.insert(contentsOf: pickedUp, at: 1)

            // Set new current cup index
            currentCupIndex = (cups.firstIndex(of: currentCupValue)! + 1) % cups.count
        }

        let indexOfOne = cups.firstIndex(of: 1)!
        var result = ""

        for index in 1 ..< cups.count {
            result += String(cups[(indexOfOne + index) % cups.count])
        }

        return Int(result)!
    }

    public func part2() -> Int {
        0
    }
}

