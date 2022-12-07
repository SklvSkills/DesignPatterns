//
//  Composite
//

// Leaf

protocol Component: AnyObject {
    func operation()
}

class Leaf: Component {
    private let number: Int
    
    init(_ number: Int) {
        self.number = number
    }
    
    func operation() {
        print("Leaf \(number)")
    }
}

// Branch

protocol Composite: Component {
    func add(_ component: Component)
    func remove(_ component: Component)
    func getComponents() -> [Component]
}

class Branch: Composite {
    private lazy var components = [Component]()
    
    func add(_ component: Component) {
        guard !components.contains(where: { $0 === component }) else {
            return
        }
        
        components.append(component)
    }
    
    func remove(_ component: Component) {
        guard let index = components.firstIndex(where: { $0 === component }) else {
            return
        }
        
        components.remove(at: index)
    }
    
    func getComponents() -> [Component] {
        components
    }
    
    func operation() {
        components.forEach {
            $0.operation()
        }
    }
}

// Client

class Client {
    func run() {
        let branch1 = Branch()
        let leaf1 = Leaf(1)
        let leaf2 = Leaf(2)
        branch1.add(leaf1)
        branch1.add(leaf2)
        
        let branch2 = Branch()
        let leaf3 = Leaf(3)
        let leaf4 = Leaf(4)
        let leaf5 = Leaf(5)
        branch2.add(leaf3)
        branch2.add(leaf4)
        branch2.add(leaf5)
        
        branch1.add(branch2)
        
        branch1.operation()
    }
}

// Client().run()

// Leaf 1
// Leaf 2
// Leaf 3
// Leaf 4
// Leaf 5
