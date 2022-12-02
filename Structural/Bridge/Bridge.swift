//
//  Bridge
//

// Shapes

enum Color: String {
    case gray
    case red
    case blue
}

protocol Shape {
    var color: Color { get set }
    func draw()
}

class Circle: Shape {
    var color = Color.gray
    
    func draw() {
        print("Draw a \(color.rawValue) circle.")
    }
}

class Square: Shape {
    var color = Color.gray
    
    func draw() {
        print("Draw a \(color.rawValue) square.")
    }
}

// Painters

protocol Painter {
    var color: Color { get }
    func draw(shape: Shape)
}

extension Painter {
    func draw(shape: Shape) {
        var shape = shape
        shape.color = color
        shape.draw()
    }
}

class RedPainter: Painter {
    let color = Color.red
}

class BluePainter: Painter {
    let color = Color.blue
}

// Client

class Client {
    func run() {
        let circle = Circle()
        let redPainter = RedPainter()
        redPainter.draw(shape: circle)
        
        let square = Square()
        let bluePainter = BluePainter()
        bluePainter.draw(shape: square)
    }
}

// Client().run()

// Draw a red circle.
// Draw a blue square.
