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
    
    private func run(day: Int) {
        switch day {
        case 3:
            print(Day3(input: input(for: day)!).part1())
        default:
            print("Not implemented")
        }
    }
    
    func input(for day: Int) -> String? {
        if let fileURL = Bundle.main.url(forResource: "AoC-2020/day\(day)", withExtension: "txt") {
            return try? String(contentsOf: fileURL)
        } else {
            print("Could not load day\(day).txt from bundle")
        }
        
        return nil
    }
}

if let files = try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.resourcePath! ){
    for file in files {
        print(file)
    }
}

_ = AOC2020()
