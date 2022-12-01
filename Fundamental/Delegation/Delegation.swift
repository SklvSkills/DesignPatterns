//
//  Delegation
//

protocol DisplayDelegate {
    func display(_ text: String)
}

// Message

class Message {
    private let text: String
    var delegate: DisplayDelegate?
    
    init(_ text: String) {
        self.text = text
    }
    
    func show() {
        delegate?.display(text)
    }
}

// Telegram

class Telegram: Message, DisplayDelegate {
    override init(_ text: String) {
        super.init(text)
        delegate = self
    }
    
    func display(_ text: String) {
        print(text)
    }
}

// Client

class Client {
    func run() {
        let telegram = Telegram("Hello, World!")
        telegram.show()
    }
}

// Client().run()

// Hello, World!
