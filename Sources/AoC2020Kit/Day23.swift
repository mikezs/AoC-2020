import Foundation

public final class Day23: Day {
    public typealias CupValue = Int

    private let input: DoubleLinkedCircleList<CupValue>

    public init(input: String) {
        self.input = DoubleLinkedCircleList<CupValue>()
        input
            .trimmedLines[0]
            .compactMap { Int(String($0)) }
            .forEach { self.input.addItem(with: $0) }
    }

    public static func play(with cups: DoubleLinkedCircleList<CupValue>, moves: Int) {
        var currentCup = cups.start!
        var currentCupValue: CupValue
        var destinationCup: DoubleLinkedCircleList<CupValue>.Item!

        for _ in 0 ..< moves {
            //print("move \(move)")
            //print("cups: \(cups.map { String($0) }.joined(separator: " "))")

            currentCupValue = currentCup.value

            // Pick 3 cups, remove cups from array
            var pickedUp = [CupValue]()

            for _ in 0 ..< 3 {
                let item = currentCup.next!
                try? cups.remove(item: item)
                pickedUp.append(item.value)
            }

            //print("pick up: \(pickedUp.map { String($0) }.joined(separator: " "))")

            // Pick destination cup
            destinationCup = nil
            var destinationCupValueTest = currentCupValue - 1

            while destinationCup == nil {
                if let item = cups.first(of: destinationCupValueTest) {
                    destinationCup = item
                    break
                }

                destinationCupValueTest -= 1

                if destinationCupValueTest < 1 {
                    destinationCupValueTest = cups.count
                }
            }

            //print("destination: \(String(destinationCupValue!))")

            // Insert cups after destination cup
            cups.insert(values: pickedUp, after: destinationCup)

            // Set new current cup index
            currentCup = currentCup.next
        }
    }

    public func part1() -> Int {
        part1(moves: 100)
    }

    public func part1(moves: Int) -> Int {
        Day23.play(with: input, moves: moves)

        var item = input.first(of: 1)!.next!
        var result = ""

        for _ in 1 ..< input.count {
            result += String(item.value)
            item = item.next
        }

        return Int(result)!
    }

    public func part2() -> Int {
        for value in input.count + 1 ... 1000000 {
            input.addItem(with: value)
        }

        Day23.play(with: input, moves: 10000000)

        let oneItem = input.first(of: 1)!
        let afterOneItem = oneItem.next!

        // 1730691995 too low
        return afterOneItem.value * afterOneItem.next.value
    }
}

