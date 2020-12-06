import Foundation

public final class Day6: Day {
    private let input: [[Set<Character>]]
    
    public init(input: String) {
        self.input = input.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n").map { group -> [Set<Character>] in
            group.components(separatedBy: .newlines).map { person -> Set<Character> in
                var set = Set<Character>()
                
                for character in person {
                    set.insert(character)
                }
                
                return set
            }
        }
    }

    public func part1() -> Int {
        var total = 0
        
        for group in input {
            var set = Set<Character>()
            
            for person in group {
                set.formUnion(person)
            }
            
            total += set.count
        }
        
        return total
    }

    public func part2() -> Int {
        var total = 0
        
        for group in input {
            var set = group.first!
            
            for person in group.suffix(from: 0) {
                set.formIntersection(person)
            }
            
            total += set.count
        }
        
        return total
    }
}
