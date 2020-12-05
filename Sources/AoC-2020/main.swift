import Foundation
import AoC2020Kit

final class AOC2020 {
    init(args: [String] = CommandLine.arguments) {
        if args.count != 2 {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
            let day = dateComponents.day!
            
            if dateComponents.year == 2020 && dateComponents.month == 12 && day < 25 {
                run(day: day)
            } else {
                run(day: 1)
            }
        } else {
            let day = Int(args[1])!
            run(day: day)
        }
    }
    
    private func run(day number: Int) {
        let days: [Int: Day.Type] = [
            1: Day1.self,
            3: Day3.self,
            4: Day4.self,
            5: Day5.self
        ]

        guard let input = self.input(for: number) else {
            fatalError("Could not load input for day \(number)")
        }

        guard let day = days[number]?.init(input: input) else {
            fatalError("Day \(number) is not yet implemented")
        }

        print("Day \(number) part 1")
        var date = Date()
        print(day.part1())
        print("(Took \(Date().timeIntervalSince(date)) seconds.)")
        print("Day \(number) part 2")
        date = Date()
        print(day.part2())
        print("(Took \(Date().timeIntervalSince(date)) seconds.)")
    }
    
    func input(for day: Int) -> String? {
        let currentFolder = FileManager.default.currentDirectoryPath

        if let fileURL = URL(string: "file://\(currentFolder)/day\(day).txt") {
            return try? String(contentsOf: fileURL)
        }

        return nil
    }
}

_ = AOC2020()
