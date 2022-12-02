//
//  Resource acquisition is initialization (RAII)
//

import Foundation

class TimerRAII {
    private let task: () -> Void
    private var timer: Timer!
    
    init(timeInterval: TimeInterval, task: @escaping () -> Void, repeats: Bool) {
        self.task = task
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(event(timer:)), userInfo: nil, repeats: repeats)
        print("Timer initialized.")
    }
    
    @objc private func event(timer: Timer) {
        task()
    }
    
    deinit {
        timer.invalidate()
        print("Timer was invalidated.")
    }
}

// Client

class Client {
    func run() {
        let _ = TimerRAII(timeInterval: 0.1, task: { print("Timer event.") }, repeats: false)
    }
}

// Client().run()

// Timer initialized.
// Timer event.
// Timer was invalidated.
