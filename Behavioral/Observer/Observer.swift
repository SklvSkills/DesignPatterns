//
//  Observer
//

import Foundation

protocol PriceObserver {
    var id: UUID { get }
    func priceReduced(from oldPrice: Int, to newPrice: Int)
}

class MacBookProPriceObserver: PriceObserver {
    let id = UUID()
    
    func priceReduced(from oldPrice: Int, to newPrice: Int) {
        let discount = ((oldPrice - newPrice) * 100) / oldPrice
        print("New price \(newPrice)$. Discount \(discount)%. " + (discount >= 25 ? "I buy." : "I don’t buy."))
    }
}

// Observable

protocol PriceObservable {
    func add(observer: PriceObserver)
    func remove(observer: PriceObserver)
    func notify(about newPrice: Int)
}

class MacBookProPriceObservable: PriceObservable {
    private lazy var observers = [UUID: PriceObserver]()
    private var price: Int
    
    init(price: Int) {
        self.price = price
    }
    
    func add(observer: PriceObserver) {
        observers[observer.id] = observer
    }
    
    func remove(observer: PriceObserver) {
        observers[observer.id] = nil
    }
    
    func notify(about newPrice: Int) {
        let oldPrice = price
        price = newPrice
        
        observers.forEach {
            $0.value.priceReduced(from: oldPrice, to: newPrice)
        }
    }
}

// Client

class Client {
    func run() {
        let shop = MacBookProPriceObservable(price: 2499)
        let me = MacBookProPriceObserver()
        shop.add(observer: me)
        
        let newPrice = 1799
        shop.notify(about: newPrice)
    }
}

// Client().run()

// New price 1799$. Discount 28%. I buy.
