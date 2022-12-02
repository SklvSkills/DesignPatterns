//
//  Object pool
//

protocol Reusable: AnyObject {
    func prepareForReuse()
}

class DynamicPool<T: Reusable> {
    private let factory: () -> T
    private var pool = [T]()
    
    init(startingAmount count: UInt, factory: @escaping () -> T) {
        self.factory = factory
        
        for _ in 0..<count {
            let object = factory()
            pool.append(object)
        }
    }
    
    deinit {
        pool = []
    }
    
    func push() -> T {
        !pool.isEmpty ? pool.removeFirst() : factory()
    }
    
    func pull(_ object: inout T?) {
        if let object = object {
            object.prepareForReuse()
            pool.append(object)
        }
        
        object = nil
    }
    
    var count: Int {
        pool.count
    }
}

// Item

class Item: Reusable {
    var value = String()
    
    func prepareForReuse() {
        value = String()
    }
}

// Client

class Client {
    func run() {
        let pool = DynamicPool(startingAmount: 3, factory: { Item() })
        print("Pool starting amount = \(pool.count)")
        
        func takeItem(value: String) -> Item {
            let item = pool.push()
            item.value = value
            print("One object was taken from the pool. It is set to \"\(item.value)\".")
            return item
        }
        
        func backItem(_ item: inout Item?) {
            pool.pull(&item)
            print("One object was returned to the pool.")
        }
        
        var a: Item? = takeItem(value: "A")
        var b: Item? = takeItem(value: "B")
        var c: Item? = takeItem(value: "C")
        var d: Item? = takeItem(value: "D")
        
        print("Pool count = \(pool.count)")
        
        backItem(&a)
        backItem(&b)
        backItem(&c)
        backItem(&d)
        
        print("Pool count = \(pool.count)")
        
        print("var a = \(a as Any)")
        print("var b = \(b as Any)")
        print("var c = \(c as Any)")
        print("var d = \(d as Any)")
    }
}

// Client().run()

// Pool starting amount = 3
// One object was taken from the pool. It is set to "A".
// One object was taken from the pool. It is set to "B".
// One object was taken from the pool. It is set to "C".
// One object was taken from the pool. It is set to "D".
// Pool count = 0
// One object was returned to the pool.
// One object was returned to the pool.
// One object was returned to the pool.
// One object was returned to the pool.
// Pool count = 4
// var a = nil
// var b = nil
// var c = nil
// var d = nil
