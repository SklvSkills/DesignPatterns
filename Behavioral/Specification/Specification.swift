//
//  Specification
//

protocol Specification {
    func isSatisfiedBy(_ candidate: Any) -> Bool
    func and(_ other: Specification) -> Specification
    func or(_ other: Specification) -> Specification
    func not() -> Specification
}

extension Specification {
    func and(_ other: Specification) -> Specification {
        AndSpecification(one: self, other: other)
    }
    
    func or(_ other: Specification) -> Specification {
        OrSpecification(one: self, other: other)
    }
    
    func not() -> Specification {
        NotSpecification(one: self)
    }
}

struct AndSpecification: Specification {
    let one: Specification
    let other: Specification
    
    func isSatisfiedBy(_ candidate: Any) -> Bool {
        one.isSatisfiedBy(candidate) && other.isSatisfiedBy(candidate)
    }
}

struct OrSpecification: Specification {
    let one: Specification
    let other: Specification
    
    func isSatisfiedBy(_ candidate: Any) -> Bool {
        one.isSatisfiedBy(candidate) || other.isSatisfiedBy(candidate)
    }
}

struct NotSpecification: Specification {
    let one: Specification
    
    func isSatisfiedBy(_ candidate: Any) -> Bool {
        !one.isSatisfiedBy(candidate)
    }
}

// Item

enum Color {
    case red, green, blue
}

enum Size {
    case small, medium, large
}

struct Item {
    let name: String
    let color: Color
    let size: Size
}

// Color specification

struct ColorSpecification: Specification {
    let color: Color
    
    func isSatisfiedBy(_ candidate: Any) -> Bool {
        guard let item = candidate as? Item else {
            return false
        }
        
        return item.color == color
    }
}

// Size specification

struct SizeSpecification: Specification {
    let size: Size
    
    func isSatisfiedBy(_ candidate: Any) -> Bool {
        guard let item = candidate as? Item else {
            return false
        }
        
        return item.size == size
    }
}

// Client

class Client {
    func run() {
        let tree = Item(name: "Tree", color: .green, size: .large)
        let frog = Item(name: "Frog", color: .green, size: .small)
        let strawberry = Item(name: "Strawberry", color: .red, size: .small)
        let items = [tree, frog, strawberry]
        
        let colorSpecification = ColorSpecification(color: .green)
        let sizeSpecification = SizeSpecification(size: .small)
        let specification = colorSpecification.and(sizeSpecification)
        
        for item in items where specification.isSatisfiedBy(item) {
            print(item.name)
        }
    }
}

// Client().run()

// Frog
