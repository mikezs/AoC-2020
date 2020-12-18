import Foundation

protocol AbstractSyntaxTree: InterpreterResult  {}
protocol InterpreterResult {}
extension Int: InterpreterResult {}

func == (lhs: Day18.Token, rhs: Day18.Token) -> Bool {
    switch (lhs, rhs) {
    case let (.integer(lhsValue), .integer(rhsValue)): return lhsValue == rhsValue
    case (.plus, .plus): return true
    case (.multiply, .multiply): return true
    case (.leftParenthesis, .leftParenthesis): return true
    case (.rightParenthesis, .rightParenthesis): return true
    case (.start, .start): return true
    default: return false
    }
}

public final class Day18: Day {
    enum Token: Equatable {
        case integer(Int)
        case plus
        case multiply
        case leftParenthesis
        case rightParenthesis
        case start
    }

    final class Lexer {
        let input: String
        var position: Int
        var current: Character?

        init(input: String) {
            self.input = input
            position = input.count - 1
            current = self.input[position]
        }

        func advance() {
            position -= 1

            if position < 0 {
                current = nil
            } else {
                current = self.input[position]
            }
        }

        func skipWhitespace() {
            while current?.isWhitespace == true {
                self.advance()
            }
        }

        func integer() -> Int {
            var result = ""

            while current?.isNumber == true {
                result += String(current!)
                self.advance()
            }

            return Int(result)!
        }

        func next() -> Token {
            while current != nil {
                if current!.isWhitespace {
                    skipWhitespace()
                    continue
                }

                if current!.isNumber {
                    return .integer(integer())
                }

                if current == "+" {
                    advance()
                    return .plus
                }

                if current == "*" {
                    advance()
                    return .multiply
                }

                if current == "(" {
                    advance()
                    return .leftParenthesis
                }

                if current == ")" {
                    advance()
                    return .rightParenthesis
                }
            }

            return .start
        }
    }

    struct Operation: AbstractSyntaxTree {
        let left: AbstractSyntaxTree
        let token: Token
        let right: AbstractSyntaxTree
    }

    struct Number: AbstractSyntaxTree {
        let token: Token
    }

    final class Parser {
        enum Error: Swift.Error {
            case invalidFactor
        }

        let lexer: Lexer
        var current: Token

        init(lexer: Lexer) {
            self.lexer = lexer
            current = lexer.next()
        }

        func consume() {
            current = lexer.next()
        }

        func factor() throws -> AbstractSyntaxTree {
            if case .integer = current {
                consume()
                return Number(token: current)
            } else if case .rightParenthesis = current {
                consume()
                let node = try expression()
                consume()
                return node
            }

            throw Error.invalidFactor
        }

        func expression() throws -> AbstractSyntaxTree {
            let node = try factor()

            while [Token.plus, Token.multiply].contains(current) {
                let token = current

                if case .plus = current {
                    consume()
                } else if case .multiply = current {
                    consume()
                }

                return Operation(left: node, token: token, right: try factor())
            }

            return node
        }

        func parse() throws -> AbstractSyntaxTree {
            return try expression()
        }
    }

    final class Interpreter {
        enum Error: Swift.Error {
            case invalidNode
            case invalidInteger
            case invalidOperation
        }
        //typealias NodeVisitor = (AbstractSyntaxTree) -> InterpreterResult

        let parser: Parser

        init(parser: Parser) {
            self.parser = parser
        }

        func interpret() throws -> Int {
            let tree = try parser.parse()
            return try visit(node: tree) as! Int
        }

        func visit(node: AbstractSyntaxTree) throws -> InterpreterResult {
            if let operation = node as? Operation {
                return try visit(operation: operation)
            } else if let number = node as? Number {
                return try visit(number: number)
            }

            throw Error.invalidNode
        }

        func visit(operation: Operation) throws -> InterpreterResult {
            if case .plus = operation.token {
                return try add(try visit(node: operation.left), try visit(node: operation.right))
            } else if case .multiply = operation.token {
                return try multiply(try visit(node: operation.left), try visit(node: operation.right))
            }

            throw Error.invalidOperation
        }

        func visit(number: Number) throws -> InterpreterResult {
            guard case let .integer(value) = number.token else {
                throw Error.invalidInteger
            }

            return value
        }

        func add(_ lhs: InterpreterResult, _ rhs: InterpreterResult) throws -> InterpreterResult {
            var lhsResult = lhs
            var rhsResult = rhs

            while !(lhsResult is Int) {
                guard let node = lhsResult as? AbstractSyntaxTree else { throw Error.invalidNode }
                lhsResult = try visit(node: node)
            }

            while !(rhsResult is Int) {
                guard let node = rhsResult as? AbstractSyntaxTree else { throw Error.invalidNode }
                rhsResult = try visit(node: node)
            }

            return (lhsResult as! Int) + (rhsResult as! Int)
        }

        func multiply(_ lhs: InterpreterResult, _ rhs: InterpreterResult) throws -> InterpreterResult {
            var lhsResult = lhs
            var rhsResult = rhs

            while !(lhsResult is Int) {
                guard let node = lhsResult as? AbstractSyntaxTree else { throw Error.invalidNode }
                lhsResult = try visit(node: node)
            }

            while !(rhsResult is Int) {
                guard let node = rhsResult as? AbstractSyntaxTree else { throw Error.invalidNode }
                rhsResult = try visit(node: node)
            }

            return (lhsResult as! Int) * (rhsResult as! Int)
        }
    }

    private let input: [String]

    public init(input: String) {
        self.input = input.trimmedLines
    }

    func result(for line: String) -> Int? {
        let lexer = Lexer(input: line)
        let parser = Parser(lexer: lexer)
        let interpreter = Interpreter(parser: parser)

        do {
            return try interpreter.interpret()
        } catch {
            print(error)
        }

        return nil
    }

    public func part1() -> Int {
        input.compactMap { result(for: $0) }.reduce(0, +)
    }

    public func part2() -> Int {
        0
    }
}
