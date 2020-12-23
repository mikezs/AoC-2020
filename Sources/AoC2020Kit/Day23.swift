import Foundation

public final class Day23: Day {
    public final class DoubleLinkedCircleList<T: Hashable> {
        enum Error: Swift.Error {
            case itemNotInList
        }

        public final class Item {
            var next: Item!
            var previous: Item!
            let value: T

            init(_ value: T) {
                self.value = value
                next = self
                previous = self
            }
        }

        public private(set) var start: Item?
        private var dict = [T: [Item]]()
        public var count: Int {
            //dict.values.map { $0.count }.reduce(0, +)
            dict.keys.count
        }

        /// Add item with value to the end of the list
        @discardableResult
        public func addItem(with value: T) -> Item {
            let item = Item(value)
            add(item)
            return item
        }

        /// Add item to the end of the list
        public func add(_ item: Item) {
            if let end = start?.previous {
                end.next = item
                item.previous = end
                item.next = start
                start?.previous = item
            } else {
                start = item
                item.next = item
                item.previous = item
            }

            addToDict(item: item)
        }

        /// Remove an item and return it. It's links are kept, but it is no longer in the list
        public func remove(item: Item) throws {
            if dict[item.value]?.count ?? 0 == 0 {
                throw Error.itemNotInList
            }

            let previous = item.previous
            let next = item.next

            previous?.next = next
            next?.previous = previous

            if item === start {
                start = item.next
            }

            dict[item.value]?.removeAll { $0 === item }
        }

        /// Find and item in the list
        public func items(of value: T) -> [Item] {
            dict[value] ?? []
        }

        public func first(of value: T) -> Item? {
            items(of: value).first
        }

        /// Insert an item after an item already in the list
        public func insert(item: Item, after: Item) {
            let next = after.next

            after.next = item
            item.previous = after
            item.next = next
            next?.previous = item

            addToDict(item: item)
        }

        public func insert(items: [Item], after: Item) {
            var currentItem = after

            for item in items {
                insert(item: item, after: currentItem)
                currentItem = item
            }
        }

        public func insert(values: [T], after: Item) {
            var currentItem = after

            for value in values {
                let item = Item(value)
                insert(item: item, after: currentItem)
                currentItem = item
            }
        }

        private func addToDict(item: Item) {
            dict[item.value] = (dict[item.value] ?? []) + [item]
        }
    }

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

        for move in 0 ..< moves {
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

