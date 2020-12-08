import Foundation

public enum Operation: String {
    case noOperation = "nop"
    case accumulator = "acc"
    case jump = "jmp"
}

public struct Instruction {
    let operation: Operation
    let value: Int
    var visited = false

    init(operation: String, value: String) {
        self.operation = Operation(rawValue: operation)!
        self.value = Int(value)!
    }

    init(operation: Operation, value: Int) {
        self.operation = operation
        self.value = value
    }
}

public final class Day8: Day {
    private let input: [Instruction]

    public init(input: String) {
        self.input = input.trimmedLines.map {
            let parts = $0.matches(for: "([a-z]{3}) \\+?(-?[0-9]+)")[0]
            return Instruction(operation: parts[0], value: parts[1])
        }
    }

    public func part1() -> Int {
        var input = self.input
        var programCounter = 0
        var accumulator = 0

        while true {
            var instruction = input[programCounter]
            let currentIndex = programCounter

            switch instruction.operation {
            case .noOperation:
                programCounter += 1
            case .jump:
                programCounter += instruction.value
            case .accumulator:
                accumulator += instruction.value
                programCounter += 1
            }

            if input[programCounter].visited {
                return accumulator
            }

            instruction.visited = true
            input[currentIndex] = instruction
        }
    }

    public func part2() -> Int {
        for (index, instruction) in input.enumerated() {
            var program = self.input

            if instruction.operation == .noOperation {
                program[index] = Instruction(operation: .jump, value: instruction.value)
            } else if instruction.operation == .jump {
                program[index] = Instruction(operation: .noOperation, value: instruction.value)
            } else if instruction.operation == .accumulator {
                continue
            }

            if let result = run(program: program) {
                return result
            }
        }

        return 0
    }

    public func run(program: [Instruction]) -> Int? {
        var program = program
        var programCounter = 0
        var accumulator = 0

        while true {
            var instruction = program[programCounter]
            let currentIndex = programCounter

            switch instruction.operation {
            case .noOperation:
                programCounter += 1
            case .jump:
                programCounter += instruction.value
            case .accumulator:
                accumulator += instruction.value
                programCounter += 1
            }

            if programCounter == program.count {
                return accumulator
            } else if program[programCounter].visited {
                return nil
            }

            instruction.visited = true
            program[currentIndex] = instruction
        }
    }
}
