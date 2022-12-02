//
//  Proxy
//

// Math

protocol Math {
    func add(_ a: Int, _ b: Int) -> Int
    func sub(_ a: Int, _ b: Int) -> Int
    func mul(_ a: Int, _ b: Int) -> Int
}

// Subject

class MathSubject: Math {
    func add(_ a: Int, _ b: Int) -> Int { a + b }
    func sub(_ a: Int, _ b: Int) -> Int { a - b }
    func mul(_ a: Int, _ b: Int) -> Int { a * b }
}

// Logging Proxy

class LoggingMathProxy: Math {
    private let math = MathSubject()
    private lazy var logs = [String]()
    
    func add(_ a: Int, _ b: Int) -> Int {
        let result = math.add(a, b)
        logs.append("Request: \(a) + \(b), Result: \(result)")
        return result
    }
    
    func sub(_ a: Int, _ b: Int) -> Int {
        let result = math.sub(a, b)
        logs.append("Request: \(a) - \(b), Result: \(result)")
        return result
    }
    
    func mul(_ a: Int, _ b: Int) -> Int {
        let result = math.mul(a, b)
        logs.append("Request: \(a) * \(b), Result: \(result)")
        return result
    }
    
    func printLogs() {
        logs.forEach {
            print($0)
        }
    }
}

// Client

class Client {
    func run() {
        let math = LoggingMathProxy()
        var value = math.add(10, 20)
        value = math.sub(value, 15)
        value = math.mul(value, 3)
        math.printLogs()
        print("Total result: \(value)")
    }
}

// Client().run()

// Request: 10 + 20, Result: 30
// Request: 30 - 15, Result: 15
// Request: 15 * 3, Result: 45
// Total result: 45
