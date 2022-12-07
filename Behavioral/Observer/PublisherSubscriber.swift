//
//  Publisher-subscriber
//

import Foundation

extension String {
    static let oldValue = "oldValue"
    static let newValue = "newValue"
}

extension NSNotification.Name {
    static let dateChanged = Notification.Name("dateChanged")
}

class DatePublisher {
    private var date = Date(timeIntervalSince1970: 0) // 1970
    
    func updateDate() {
        let oldDate = date
        date = date.addingTimeInterval(Double(2 << 30)) // Adds about 68 years.
        
        let info: [String: Date] = [.oldValue: oldDate, .newValue: date]
        NotificationCenter.default.post(name: .dateChanged, object: nil, userInfo: info)
    }
}

class DateSubscriber {
    private var changes = "No changes"
    
    init() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(dateChanged(_:)), name: .dateChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func dateChanged(_ notification: NSNotification) {
        guard let info = notification.userInfo as? [String: Date],
              let oldValue = info[.oldValue],
              let newValue = info[.newValue] else {
            return
        }
        
        changes = "Date changed from: \(oldValue), updated to: \(newValue)"
    }
    
    func showСhanges() {
        print(changes)
    }
}

// Client

class Client {
    func run() {
        let publisher = DatePublisher()
        let subscriber = DateSubscriber()
        publisher.updateDate()
        subscriber.showСhanges()
    }
}

// Client().run()

// Date changed from: 1970-01-01 00:00:00 +0000, updated to: 2038-01-19 03:14:08 +0000
