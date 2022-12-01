//
//  Immutable interface
//

protocol ImmutablePoint {
    var x: Int { get }
    var y: Int { get }
}

struct Point: ImmutablePoint {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

// Client

class Client {
    func run() {
        var point = Point(x: 0, y: 0)
        point.x = 10
        point.y = 20
        
        var immutablePoint: ImmutablePoint = Point(x: 0, y: 0)
        immutablePoint.x = 10 // Compile error: 'x' is a get-only property
        immutablePoint.y = 20 // Compile error: 'y' is a get-only property
    }
}
