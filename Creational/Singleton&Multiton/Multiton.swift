//
//  Multiton
//

enum MultitonType: String {
    case one, two, three
}

class Multiton {
    private let type: MultitonType
    
    private init(_ type: MultitonType) {
        self.type = type
    }
    
    func printType() {
        print("My type is \(type.rawValue).")
    }
}

extension Multiton {
    private static var instances = [MultitonType: Multiton]()
    
    static func instance(_ type: MultitonType) -> Multiton {
        if let instance = instances[type] {
            return instance
        }
        
        let instance = Multiton(type)
        instances[type] = instance
        return instance
    }
}

// Client

class Client {
    func run() {
        let instance1 = Multiton.instance(.one)
        let instance2 = Multiton.instance(.two)
        let instance3 = Multiton.instance(.three)
        
        instance1.printType()
        instance2.printType()
        instance3.printType()
        
        let instance4 = Multiton.instance(.one)
        let instance5 = Multiton.instance(.two)
        let instance6 = Multiton.instance(.three)
        
        if (instance1 === instance4) && (instance2 === instance5) && (instance3 === instance6) {
            print("Multiton works.")
        } else {
            print("Multiton failed.")
        }
    }
}

// Client().run()

// My type is one.
// My type is two.
// My type is three.
// Multiton works.
