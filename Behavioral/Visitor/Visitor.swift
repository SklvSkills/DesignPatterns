//
//  Visitor
//

// Shapes

protocol Shape {
    func accept(_ visitor: Visitor)
}

class Rectangle: Shape {
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func accept(_ visitor: Visitor) {
        visitor.calc(element: self)
    }
}

class Cuboid: Shape {
    let width: Int
    let height: Int
    let depth: Int
    
    init(width: Int, height: Int, depth: Int) {
        self.width = width
        self.height = height
        self.depth = depth
    }
    
    func accept(_ visitor: Visitor) {
        visitor.calc(element: self)
    }
}

// Visitors

protocol Visitor {
    func calc(element: Rectangle)
    func calc(element: Cuboid)
}

class Area: Visitor {
    func calc(element: Rectangle) {
        let w = element.width
        let h = element.height
        let s = w * h
        print("Rectangle: width = \(w), height = \(h), area = \(s).")
    }
    
    func calc(element: Cuboid) {
        let w = element.width
        let h = element.height
        let d = element.depth
        let s = (2 * w * h) + (2 * h * d) + (2 * w * d)
        print("Cuboid: width = \(w), height = \(h), depth = \(d), area = \(s).")
    }
}

class Volume: Visitor {
    func calc(element: Rectangle) {
        let w = element.width
        let h = element.height
        let v = 0
        print("Rectangle: width = \(w), height = \(h), volume = \(v).")
    }
    
    func calc(element: Cuboid) {
        let w = element.width
        let h = element.height
        let d = element.depth
        let v = w * h * d
        print("Cuboid: width = \(w), height = \(h), depth = \(d), volume = \(v).")
    }
}

// Client

class Client {
    func run() {
        let area = Area()
        let volume = Volume()
        
        let rectangle = Rectangle(width: 12, height: 34)
        rectangle.accept(area)
        rectangle.accept(volume)
        
        let cuboid = Cuboid(width: 56, height: 78, depth: 90)
        cuboid.accept(area)
        cuboid.accept(volume)
    }
}

// Client().run()

// Rectangle: width = 12, height = 34, area = 408.
// Rectangle: width = 12, height = 34, volume = 0.
// Cuboid: width = 56, height = 78, depth = 90, area = 32856.
// Cuboid: width = 56, height = 78, depth = 90, volume = 393120.
