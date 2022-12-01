//
//  Builder
//

// House

class House {
    var parts = [String]()
}

// Builders

protocol HouseBuilder: AnyObject {
    func buildWalls()
    func buildDoors()
    func buildWindows()
    func buildRoof()
    func buildGarage()
    func buildSwimmingPool()
    func buildFancyStatues()
    func buildGarden()
    func getResult() -> House
}

class WoodHouseBuilder: HouseBuilder {
    private let house = House()
    
    func buildWalls() {
        house.parts.append("wood walls")
    }
    
    func buildDoors() {
        house.parts.append("wood doors")
    }
    
    func buildWindows() {
        house.parts.append("wood windows")
    }
    
    func buildRoof() {
        house.parts.append("wood roof")
    }
    
    func buildGarage() {
        house.parts.append("wood garage")
    }
    
    func buildSwimmingPool() {
        house.parts.append("swimming pool")
    }
    
    func buildFancyStatues() {
        house.parts.append("wood fancy statues")
    }
    
    func buildGarden() {
        house.parts.append("garden")
    }
    
    func getResult() -> House {
        house
    }
}

class StoneHouseBuilder: HouseBuilder {
    private let house = House()
    
    func buildWalls() {
        house.parts.append("stone walls")
    }
    
    func buildDoors() {
        house.parts.append("iron doors")
    }
    
    func buildWindows() {
        house.parts.append("plastic windows")
    }
    
    func buildRoof() {
        house.parts.append("stone roof")
    }
    
    func buildGarage() {
        house.parts.append("stone garage")
    }
    
    func buildSwimmingPool() {
        house.parts.append("swimming pool")
    }
    
    func buildFancyStatues() {
        house.parts.append("stone fancy statues")
    }
    
    func buildGarden() {
        house.parts.append("garden")
    }
    
    func getResult() -> House {
        house
    }
}

// Director

class Director {
    private unowned var builder: HouseBuilder
    
    init(for builder: HouseBuilder) {
        self.builder = builder
    }
    
    func changeBuilder(to builder: HouseBuilder) {
        self.builder = builder
    }
    
    func makeHouse(garage: Bool = false, swimmingPool: Bool = false, fancyStatues: Bool = false, garden: Bool = false) {
        builder.buildWalls()
        builder.buildDoors()
        builder.buildWindows()
        builder.buildRoof()
        
        if garage {
            builder.buildGarage()
        }
        
        if swimmingPool {
            builder.buildSwimmingPool()
        }
        
        if fancyStatues {
            builder.buildFancyStatues()
        }
        
        if garden {
            builder.buildGarden()
        }
    }
}

// Client

class Client {
    func run() {
        let builder = StoneHouseBuilder()
        
        let director = Director(for: builder)
        director.makeHouse(garage: true)
        
        let house = builder.getResult()
        print("House: \(house.parts)")
    }
}

// Client().run()

// House: ["stone walls", "iron doors", "plastic windows", "stone roof", "stone garage"]
