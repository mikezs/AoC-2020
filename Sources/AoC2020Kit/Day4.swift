import Foundation

extension Int {
    init?(_ string: String?) {
        guard let string = string else { return nil }
        self.init(string)
    }
}

private struct Height {
    enum Unit: String {
        case centimeters = "cm"
        case inch = "in"
    }

    let amount: Int
    let unit: Unit

    init?(_ string: String?) {
        guard let string = string else { return nil }
        guard let amount = Int(String(string.dropLast(2))) else { return nil }

        if string.hasSuffix("cm") {
            self.unit = .centimeters
        } else if string.hasSuffix("in") {
            self.unit = .inch
        } else {
            return nil
        }

        self.amount = amount
    }

    var isValid: Bool {
        switch unit {
        case .centimeters:
            return amount >= 150 && amount <= 193
        case .inch:
            return amount >= 59 && amount <= 76
        }
    }
}

private struct Document {
    enum EyeColor: String {
        case amb
        case blu
        case brn
        case gry
        case grn
        case hzl
        case oth
    }

    let birthYear: Int?
    let issueYear: Int?
    let expireYear: Int?
    let height: Height?
    let hairColor: String?
    let eyeColor: EyeColor?
    let passportID: String?
    let countryID: String?

    init(document: [String: String]) {
        birthYear = Int(document["byr"])
        issueYear = Int(document["iyr"])
        expireYear = Int(document["eyr"])
        height = Height(document["hgt"])
        hairColor = document["hcl"]
        eyeColor = EyeColor(rawValue: document["ecl"] ?? "")
        passportID = document["pid"]
        countryID = document["cid"]
    }

    var isValid: Bool {
        return
            birthYear != nil && birthYear! >= 1920 && birthYear! <= 2002 &&
            issueYear != nil && issueYear! >= 2010 && issueYear! <= 2020 &&
            expireYear != nil && expireYear! >= 2020 && expireYear! <= 2030 &&
            height != nil && height!.isValid &&
            hairColor != nil && hairColor(isValid: hairColor!) &&
            eyeColor != nil &&
            passportID != nil && passportID?.count == 9 && Int(passportID!) != nil
    }

    private func hairColor(isValid hairColor: String) -> Bool {
        hairColor ~= "#[0-9a-f]{6}"
    }
}

public final class Day4: Day {
    private let input: [[String: String]]

    public init(input: String) {
        self.input = input.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n").map {
            var document = [String: String]()
            let fields = $0.components(separatedBy: .whitespacesAndNewlines)

            fields.forEach {
                let parts = $0.components(separatedBy: ":")
                document[parts[0]] = parts[1]
            }

            return document
        }
    }

    public func part1() -> Int {
        input.filter { document in
            let keys = document.keys

            return
                keys.contains("byr") &&
                keys.contains("iyr") &&
                keys.contains("eyr") &&
                keys.contains("hgt") &&
                keys.contains("hcl") &&
                keys.contains("ecl") &&
                keys.contains("pid")
        }.count
    }

    public func part2() -> Int {
        input.map { Document(document: $0) }.filter { $0.isValid }.count
    }
}
