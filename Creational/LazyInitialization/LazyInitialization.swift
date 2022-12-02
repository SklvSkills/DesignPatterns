//
//  Lazy initialization
//

struct Rectangle {
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        print("Initialization of the rectangle.")
        self.width = width
        self.height = height
    }
    
    private(set) lazy var area: Int = {
        print("Lazy initialization of the area.")
        return width * height
    }()
}

// Client

class Client {
    func run() {
        var rectangle = Rectangle(width: 12, height: 34)
        print("Rectangle: width = \(rectangle.width), height = \(rectangle.height).")
        print("Rectangle: area = \(rectangle.area).")
    }
}

// Client().run()

// Initialization of the rectangle.
// Rectangle: width = 12, height = 34.
// Lazy initialization of the area.
// Rectangle: area = 408.
