//
//  Singleton
//

class Singleton {
    static let shared = Singleton()
    private init() { }
}

// Client

class Client {
    func run() {
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared
        
        if instance1 === instance2 {
            print("Singleton works.")
        } else {
            print("Singleton failed.")
        }
    }
}

// Client().run()

// Singleton works.
