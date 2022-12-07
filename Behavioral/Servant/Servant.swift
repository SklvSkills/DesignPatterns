//
//  Servant
//

import CoreGraphics

protocol Movable {
    func getPosition() -> CGPoint
    func setPosition(_ position: CGPoint)
}

class MoveServant {
    func moveTo(_ serviced: Movable, position: CGPoint) {
        serviced.setPosition(position)
    }
    
    func moveBy(_ serviced: Movable, dx: CGFloat, dy: CGFloat) {
        var position = serviced.getPosition()
        position.x += dx
        position.y += dy
        serviced.setPosition(position)
    }
}

// Shape

class Rectangle: Movable {
    private var rect: CGRect
    
    init(_ rect: CGRect) {
        self.rect = rect
    }
    
    func getPosition() -> CGPoint {
        rect.origin
    }
    
    func setPosition(_ point: CGPoint) {
        rect.origin = point
    }
}

// Client

class Client {
    func run() {
        let rectangle = Rectangle(CGRect(x: 10, y: 20, width: 30, height: 40))
        print("Rectangle position: \(rectangle.getPosition())")
        
        let servant = MoveServant()
        servant.moveBy(rectangle, dx: 90, dy: 80)
        print("Rectangle position: \(rectangle.getPosition())")
    }
}

// Client().run()

// Rectangle position: (10.0, 20.0)
// Rectangle position: (100.0, 100.0)
