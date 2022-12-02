//
//  Data access object
//

import Foundation

protocol DataAccessObject {
    associatedtype T
    func createObject(key: String, value: T)
    func readValue(for key: String) -> T?
    func updateValue(_ newValue: T, for key: String) -> Bool
    func deleteObject(with key: String)
}

class Storage<T>: DataAccessObject {
    private let storage = UserDefaults.standard
    
    func createObject(key: String, value: T) {
        storage.set(value, forKey: key)
    }
    
    func readValue(for key: String) -> T? {
        storage.object(forKey: key) as? T
    }
    
    @discardableResult
    func updateValue(_ newValue: T, for key: String) -> Bool {
        guard let _: T = readValue(for: key) else {
            return false
        }
        
        storage.set(newValue, forKey: key)
        return true
    }
    
    func deleteObject(with key: String) {
        storage.removeObject(forKey: key)
    }
}

// Client

class Client {
    func run() {
        let integerStorage = Storage<Int>()
        let testKey = "Test"
        
        integerStorage.createObject(key: testKey, value: 0)
        print(integerStorage.readValue(for: testKey) as Any)
        
        integerStorage.updateValue(100, for: testKey)
        print(integerStorage.readValue(for: testKey) as Any)
        
        integerStorage.deleteObject(with: testKey)
        print(integerStorage.readValue(for: testKey) as Any)
    }
}

// Client().run()

// Optional(0)
// Optional(100)
// nil
