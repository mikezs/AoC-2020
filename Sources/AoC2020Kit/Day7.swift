import Foundation

public final class Day7: Day {
    typealias BagColor = String
    
    private let search = "shiny gold"
    private let input: [BagColor: [BagColor: Int]]
    
    public init(input: String) {
        self.input = input.trimmedLines.reduce([BagColor: [BagColor: Int]](), { dict, rule in
            let parts = rule.components(separatedBy: " bags contain ")
            let matches = parts[1].matches(for: "([0-9]+) (.*?) bag")
            var dict = dict
            
            dict[parts[0]] = matches.reduce([BagColor: Int]()) {
                var dict = $0
                dict[$1[1]] = Int($1[0])!
                return dict
            }
            
            return dict
        })
    }

    public func part1() -> Int {
        input.filter { bag($0.key, contains: search) }.count
    }
    
    private func bag(_ bag: BagColor, contains search: BagColor) -> Bool {
        if input[bag]?.keys.contains(search) == true {
            return true
        }
        
        return input[bag]?.contains { self.bag($0.key, contains: search) } == true
    }

    public func part2() -> Int {
        colors(for: search)
    }
    
    private func colors(for bag: BagColor) -> Int {
        input[bag]!
            .compactMap {
                $1 + (self.colors(for: $0) * $1)
            }
            .reduce(0, +)
    }
}
