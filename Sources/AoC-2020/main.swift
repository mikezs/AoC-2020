import Foundation

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
            print(Day3().part1(input: input(for: day)!))
        default:
            print("Not implemented")
        }
    }
    
    func input(for day: Int) -> String? {
        if let fileURL = Bundle.main.url(forResource: "day\(day)", withExtension: "txt") {
            return try? String(contentsOf: fileURL)
        }
        
        return nil
    }
}

_ = AOC2020()
