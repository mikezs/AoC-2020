import Foundation

protocol Day16Protocol: Day {
    var namedValues: [String: Int] { get }
}

public final class Day16: Day16Protocol {
    typealias Ticket = [Int]

    struct Field: Equatable {
        let name: String
        let range1: ClosedRange<Int>
        let range2: ClosedRange<Int>

        init(from field: String) {
            let matches = field.matches(for: "([^:]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)")[0]
            name = matches[0]
            range1 = Int(matches[1])!...Int(matches[2])!
            range2 = Int(matches[3])!...Int(matches[4])!
        }

        func contains(_ value: Int) -> Bool {
            range1.contains(value) || range2.contains(value)
        }

        static func == (lhs: Field, rhs: Field) -> Bool {
                return
                    lhs.name == rhs.name &&
                    lhs.range1 == rhs.range1 &&
                    lhs.range2 == rhs.range2
            }
    }

    private let fields: [Field]
    private let ticket: Ticket
    private let nearbys: [Ticket]

    public init(input: String) {
        let parts = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")

        fields = parts[0]
            .trimmedLines
            .map { Field(from: $0) }
        ticket = parts[1]
            .trimmedLines[1]
            .components(separatedBy: ",")
            .map { Int($0)! }
        nearbys = parts[2]
            .trimmedLines
            .suffix(from: 1)
            .map { $0.components(separatedBy: ",").map { Int($0)! } }
    }

    private func isInvalid(ticket: Ticket) -> Int? {
        ticket.first { value in
            fields
                .filter { $0.contains(value) }
                .isEmpty
        }
    }

    public func part1() -> Int {
        nearbys
            .compactMap { isInvalid(ticket: $0) }
            .reduce(0, +)
    }

    private func fieldsPossibleForIndexes(for tickets: [Ticket]) -> [Int: [Field]] {
        (0..<ticket.count)
            .reduce([Int: [Field]]()) { dict, index in
                dict.adding(key: index, value: fields.filter { field in
                    tickets
                        .map { $0[index] }
                        .allSatisfy { field.contains($0) }
                })
            }
    }

    private func eliminate(singlePossiblityFields: [Field], from possibleFields: [Int: [Field]]) -> [Int: [Field]] {
        possibleFields
            .mapValues { fields in
                if fields.count > 1 {
                    return fields
                        .filter { !singlePossiblityFields.contains($0) }
                }

                return fields
            }
    }

    private func reduceFieldsForIndexes(in possibleValidFields: [Int: [Field]]) -> [Int: [Field]] {
        var validFields = possibleValidFields

        while true {
            let singleFields = singlePossibilityFields(validFields: validFields)

            if singleFields.count == ticket.count {
                return validFields
            }

            validFields = eliminate(singlePossiblityFields: singleFields, from: validFields)
        }
    }

    private func singlePossibilityFields(validFields: [Int: [Field]]) -> [Field] {
        validFields
            .map { $0.value }
            .filter { $0.count == 1 }
            .map { $0[0] }
    }

    public var namedValues: [String: Int] {
        let filteredNearbys = nearbys.filter { isInvalid(ticket: $0) == nil }
        let validFields = fieldsPossibleForIndexes(for: filteredNearbys)
        let fieldsForIndexes = reduceFieldsForIndexes(in: validFields)

        return fieldsForIndexes.reduce([String: Int](), {
            $0.adding(key: $1.value[0].name, value: ticket[$1.key])
        })
    }

    public func part2() -> Int {
        namedValues
            .filter { $0.key.contains("departure") }
            .map { $0.value }.reduce(1, *)
    }
}
