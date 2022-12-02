//
//  Service locator
//

final class ServiceLocator {
    private lazy var registry = [String: Any]()
    
    func add<T>(_ service: T) {
        registry["\(T.self)"] = service
    }
    
    func get<T>() -> T? {
        registry["\(T.self)"] as? T
    }
    
    // Singleton
    static let shared = ServiceLocator()
    private init() { }
}

// Messager

class Messager {
    func send(text: String) {
        print(text)
    }
}

// Client

class Client {
    func run() {
        ServiceLocator.shared.add(Messager())
        
        if let messager: Messager = ServiceLocator.shared.get() {
            messager.send(text: "Hello, World!")
        }
    }
}

// Client().run()

// Hello, World!
