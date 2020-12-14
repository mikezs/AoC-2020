import Foundation

protocol Bitmask {}

extension Int {
    public func apply(mask: Day14.Mask) -> Int {
        var value = self

        value |= mask.oneValue
        value &= mask.zeroValue

        return value
    }
}

public final class Day14: Day {
    public struct Mask: Bitmask {
        let zeroValue: Int
        let oneValue: Int
        let floatingValue: Int

        public init(_ string: String) {
            self.zeroValue = Int(string
                                    .replacingOccurrences(of: "X", with: "1"),
                                 radix: 2)!

            self.oneValue = Int(string
                                    .replacingOccurrences(of: "X", with: "0"),
                                 radix: 2)!

            self.floatingValue = Int(string
                                        .replacingOccurrences(of: "1", with: "0")
                                        .replacingOccurrences(of: "X", with: "1"),
                                     radix: 2)!
        }

        public init(zeroValue: Int, oneValue: Int) {
            self.zeroValue = zeroValue
            self.oneValue = oneValue
            floatingValue = 0
        }
    }

    public struct Write: Bitmask {
        let location: Int
        let value: Int
        private let zeroMask = Int(pow(Double(2),Double(36))) - 1

        public init(location: Int, value: Int) {
            self.location = location
            self.value = value
        }

        public func apply(mask: Mask) -> Int {
            self.value.apply(mask: mask)
        }

        public func addresses(for mask: Mask) -> [Int] {
            let maskedLocation = self.location | mask.oneValue

            var floatingIndexes = [Int]()

            for bit in 0..<36 {
                if (1 << bit) & mask.floatingValue != 0 {
                    floatingIndexes.append(bit)
                }
            }

            var addresses = [Int]()

            for floatingValue in 0..<Int(pow(Double(2),Double(floatingIndexes.count))) {
                var zeroValue = zeroMask
                var oneValue = 0

                for (index, power) in floatingIndexes.enumerated() {
                    let bitValue = (floatingValue >> index) & 0x1

                    if bitValue == 0x1 {
                        oneValue |= bitValue << power
                    } else {
                        zeroValue ^= 0x1 << power
                    }
                }

                let floatingMask = Mask(zeroValue: zeroValue, oneValue: oneValue)
                var address = maskedLocation
                address |= floatingMask.oneValue
                address &= floatingMask.zeroValue
                addresses.append(address)
            }

            return addresses
        }
    }

    private let input: [Bitmask]

    public init(input: String) {
        self.input = input.trimmedLines.compactMap { line in
            let maskMatches = line.matches(for: "mask = ([01X]+)")

            if maskMatches.count != 0 {
                return Mask(maskMatches[0][0])
            } else {
                let writeMatches = line.matches(for: "mem\\[([0-9]+)\\] = (.*)")

                if writeMatches.count != 0 {
                    return Write(location: Int(writeMatches[0][0])!, value: Int(writeMatches[0][1])!)
                }
            }

            return nil
        }
    }

    public func part1() -> Int {
        var currentMask: Mask?
        var memory = [Int: Int]()

        input.forEach { instruction in
            if let mask = instruction as? Mask {
                currentMask = mask
            } else if let write = instruction as? Write {
                memory[write.location] = write.apply(mask: currentMask!)
            }
        }

        return memory.values.reduce(0, +)
    }

    public func part2() -> Int {
        var currentMask: Mask?
        var memory = [Int: Int]()

        input.forEach { instruction in
            if let mask = instruction as? Mask {
                currentMask = mask
            } else if let write = instruction as? Write {
                write
                    .addresses(for: currentMask!)
                    .forEach {
                        memory[$0] = write.value
                    }
            }
        }

        return memory.values.reduce(0, +)
    }
}
