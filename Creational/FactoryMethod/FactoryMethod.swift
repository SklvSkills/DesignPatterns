//
//  Factory method
//

// Transport

protocol Transport {
    static var maxLoad: Int { get }
    var loaded: Int { get }
    func load(_ cargo: Int)
    func go()
}

class Truck: Transport {
    static let maxLoad = 20
    private(set) var loaded = 0
    
    func load(_ cargo: Int) {
        loaded += cargo
    }
    
    func go() {
        print("Deliver the cargo by land in a box.")
    }
}

class Ship: Transport {
    static let maxLoad = 150
    private(set) var loaded = 0
    
    func load(_ cargo: Int) {
        loaded += cargo
    }
    
    func go() {
        print("Deliver the cargo by sea in a container.")
    }
}

// Logistics

protocol Logistics {
    static var maxLoad: Int { get }
    func deliver(_ cargo: Int)
    func createTransport() -> Transport
}

extension Logistics {
    func deliver(_ cargo: Int) {
        let transport = createTransport()
        transport.load(cargo)
        transport.go()
    }
}

class RoadLogistics: Logistics {
    static let maxLoad = Truck.maxLoad
    
    func createTransport() -> Transport {
        Truck()
    }
}

class SeaLogistics: Logistics {
    static let maxLoad = Ship.maxLoad
    
    func createTransport() -> Transport {
        Ship()
    }
}

// Client

class Client {
    func run(cargo: Int) {
        var logistics: Logistics?
        
        if cargo <= RoadLogistics.maxLoad {
            logistics = RoadLogistics()
        } else if cargo <= SeaLogistics.maxLoad {
            logistics = SeaLogistics()
        } else {
            print("Delivery is not possible. Too heavy.")
            return
        }
        
        logistics?.deliver(cargo)
    }
}

// Client().run(cargo: 50)

// Deliver the cargo by sea in a container.
