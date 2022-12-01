//
//  Abstract factory
//

// Products

protocol Product {
    var title: String { get }
}

protocol Chair: Product {
    var hasLegs: Bool { get }
    func sitOn()
}

protocol Sofa: Product {
    var hasLegs: Bool { get }
    func sitOn()
}

// Style: Victorian

class VictorianChair: Chair {
    let title = "Victorian chair"
    let hasLegs = true
    func sitOn() { }
}

class VictorianSofa: Sofa {
    let title = "Victorian sofa"
    let hasLegs = true
    func sitOn() { }
}


// Style: Modern

class ModernChair: Chair {
    let title = "Modern chair"
    let hasLegs = false
    func sitOn() { }
}

class ModernSofa: Sofa {
    let title = "Modern sofa"
    let hasLegs = false
    func sitOn() { }
}

// Factories

protocol FurnitureFactory {
    func createChair() -> Chair
    func createSofa() -> Sofa
}

class VictorianFurnitureFactory: FurnitureFactory {
    func createChair() -> Chair {
        VictorianChair()
    }
    
    func createSofa() -> Sofa {
        VictorianSofa()
    }
}

class ModernFurnitureFactory: FurnitureFactory {
    func createChair() -> Chair {
        ModernChair()
    }
    
    func createSofa() -> Sofa {
        ModernSofa()
    }
}

// Client

class Client {
    func run(style: String) {
        var furnitureFactory: FurnitureFactory?
        
        switch style {
        case "Victorian":
            furnitureFactory = VictorianFurnitureFactory()
        case "Modern":
            furnitureFactory = ModernFurnitureFactory()
        default:
            print("Our factories do not create this style.")
        }
        
        guard let factory = furnitureFactory else { return }
        
        var products = [Product]()
        
        let chair = factory.createChair()
        products.append(chair)
        
        let sofa = factory.createSofa()
        products.append(sofa)
        
        print("Factory has created:")
        for (index, product) in products.enumerated() {
            print("\(index+1). \(product.title)")
        }
    }
}

// Client().run(style: "Modern")

// Factory has created:
// 1. Modern chair
// 2. Modern sofa
