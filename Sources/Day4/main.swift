import Foundation
import Regex

struct Passport {
    let birthYear: Int
    let issueYear: Int
    let expirationYear: Int
    let height: String
    let hairColor: String
    let eyeColor: String
    let passportId: String
    let countryId: String?

    init?(from dictionary: [String: String]) {
        guard let birthYearStr = dictionary["byr"],
              let birthYear = Int(birthYearStr),
              let issueYearStr = dictionary["iyr"],
              let issueYear = Int(issueYearStr),
              let expirationYearStr = dictionary["eyr"],
              let expirationYear = Int(expirationYearStr),
              let height = dictionary["hgt"],
              let hairColor = dictionary["hcl"],
              let eyeColor = dictionary["ecl"],
              let passportId = dictionary["pid"]
        else {
            return nil
        }

        guard (1920...2002).contains(birthYear),
              (2010...2020).contains(issueYear),
              (2020...2030).contains(expirationYear),
              Self.validateHeight(height: height),
              Self.hairColorRegex.matches(hairColor),
              ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(eyeColor),
              Self.passportIdRegex.matches(passportId)
        else {
            return nil
        }

        self.birthYear = birthYear
        self.issueYear = issueYear
        self.expirationYear = expirationYear
        self.height = height
        self.hairColor = hairColor
        self.eyeColor = eyeColor
        self.passportId = passportId
        self.countryId = dictionary["cid"]
    }

    static func validateHeight(height: String) -> Bool {
        if height.contains("cm") {
            guard let value = Int(height.replacingOccurrences(of: "cm", with: "")) else { return false }
            return (150...193).contains(value)
        } else if height.contains("in") {
            guard let value = Int(height.replacingOccurrences(of: "in", with: "")) else { return false }
            return (59...76).contains(value)
        }
        return false
    }

    static let hairColorRegex = Regex("#(?:[0-9]|[a-f]){6}")
    static let passportIdRegex = Regex(#"^\d{9}$"#)
}

let validPassports = inputStr.components(separatedBy: "\n\n")
    .map { data -> [String: String] in
        let keyValuePairs = data.replacingOccurrences(of: "\n", with: " ")
            .components(separatedBy: .whitespaces)
            .map { $0.components(separatedBy: ":") }
            .map { ($0[0], $0[1]) }
        return Dictionary(uniqueKeysWithValues: keyValuePairs)
    }
    .compactMap(Passport.init)

print(validPassports.count)
