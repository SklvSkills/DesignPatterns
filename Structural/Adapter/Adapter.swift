//
//  Adapter
//

// Adaptee

class sumNumbers {
    func sum(_ numbers: [Int]) -> Int {
        numbers.reduce(0, +)
    }
}

// Adapter

protocol SumDigitWords {
    func sum(_ digitWords: [String]) -> Int
}

class SumAdapter: SumDigitWords {
    private func convert(_ digitWords: [String]) -> [Int] {
        var digits = [Int]()
        
        for word in digitWords {
            switch word {
            case "zero":
                digits.append(0)
            case "one":
                digits.append(1)
            case "two":
                digits.append(2)
            case "three":
                digits.append(3)
            case "four":
                digits.append(4)
            case "five":
                digits.append(5)
            case "six":
                digits.append(6)
            case "seven":
                digits.append(7)
            case "eight":
                digits.append(8)
            case "nine":
                digits.append(9)
            default:
                break
            }
        }
        
        return digits
    }
    
    func sum(_ digitWords: [String]) -> Int {
        let digits = convert(digitWords)
        return sumNumbers().sum(digits)
    }
}

// Client

class Client {
    func run() {
        let digitWords = ["four", "nine", "seven", "six", "eight", "two", "three", "one", "five", "nine"]
        let sum = SumAdapter().sum(digitWords)
        print("Sum: \(sum)")
    }
}

// Client().run()

// Sum: 54
