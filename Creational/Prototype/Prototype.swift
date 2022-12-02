//
//  Prototype
//

protocol Prototype {
    associatedtype Item: Equatable
    func clone() -> Item
}

// Droid

class Droid: Prototype, Equatable {
    let model: String
    
    required init(_ model: String) {
        self.model = model
    }
    
    // Prototype
    func clone() -> Droid {
        type(of: self).init(model)
    }
    
    // Equatable
    static func == (lhs: Droid, rhs: Droid) -> Bool {
        lhs.model == rhs.model
    }
}

// Client

class Client {
    func run() {
        let prototype = Droid("R2-D2")
        let clone = prototype.clone()
        
        print("Is the clone a copy of the prototype?")
        print(clone == prototype ? "Yes" : "No")
    }
}

// Client().run()

// Is the clone a copy of the prototype?
// Yes
