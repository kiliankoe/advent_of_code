import Regex

struct Line {
    let lower: Int
    let upper: Int
    let requirement: Character
    let password: String

    private static let ruleRegex = Regex(#"(\d+)-(\d+) (.): (.+)"#)

    init(from string: String) {
        let match = Self.ruleRegex.allMatches(in: string)[0].captures.compactMap { $0 }
        self.lower = Int(match[0])!
        self.upper = Int(match[1])!
        self.requirement = Character(match[2])
        self.password = match[3]
    }

    var isValid: Bool {
        (lower...upper).contains(
            password.reduce(0) { $1 == requirement ? $0 + 1 : $0 }
        )
    }

    var isValid2: Bool {
        let firstPos = password[password.index(password.startIndex, offsetBy: lower - 1)]
        let secondPos = password[password.index(password.startIndex, offsetBy: upper - 1)]
        return (firstPos == requirement) != (secondPos == requirement)
    }
}

let passwords = inputStr
    .components(separatedBy: .newlines)
    .map(Line.init)

print(passwords.filter(\.isValid).count)
print(passwords.filter(\.isValid2).count)
