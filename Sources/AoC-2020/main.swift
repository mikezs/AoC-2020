import Foundation
import AoC2020Kit

final class AOC2020 {
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 3
        formatter.minimumSignificantDigits = 3

        return formatter
    }()

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
            2: Day2.self,
            3: Day3.self,
            4: Day4.self,
            5: Day5.self,
            6: Day6.self,
            7: Day7.self,
            8: Day8.self,
            9: Day9.self,
            10: Day10.self
        ]

        guard let input = self.input(for: number) else {
            fatalError("Could not load input for day \(number)")
        }

        guard let day = days[number]?.init(input: input) else {
            fatalError("Day \(number) is not yet implemented")
        }

        var date = Date()
        let part1 = day.part1()
        let part1Time = formatter.string(from: NSNumber(value: Date().timeIntervalSince(date))) ?? "N/A"
        date = Date()
        let part2 = day.part2()
        let part2Time = formatter.string(from: NSNumber(value: Date().timeIntervalSince(date))) ?? "N/A"

        #if DEBUG
        let target = "debug"
        #else
        let target = "release"
        #endif

        print("Running Day \(number) as \(target)")
        print("Day \(number) Part 1 took \(part1Time) seconds")
        print("Day \(number) Part 2 took \(part2Time) seconds")
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
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
