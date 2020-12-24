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
