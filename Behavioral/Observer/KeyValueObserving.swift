//
//  Key-value observing
//

import Foundation

class DateToObserve: NSObject {
    @objc dynamic var date = Date(timeIntervalSince1970: 0) // 1970
    
    func updateDate() {
        date = date.addingTimeInterval(Double(2 << 30)) // Adds about 68 years.
    }
}

class DateObserver {
    private var token: NSKeyValueObservation?
    private var changes = "No changes"
    
    init(object: DateToObserve) {
        token = object.observe(\.date, options: [.old, .new]) { [weak self] object, change in
            self?.changes = "Date changed from: \(change.oldValue!), updated to: \(change.newValue!)"
        }
    }
    
    deinit {
        token?.invalidate()
    }
    
    func showСhanges() {
        print(changes)
    }
}

// Client

class Client {
    func run() {
        let observed = DateToObserve()
        let observer = DateObserver(object: observed)
        observed.updateDate()
        observer.showСhanges()
    }
}

// Client().run()

// Date changed from: 1970-01-01 00:00:00 +0000, updated to: 2038-01-19 03:14:08 +0000
