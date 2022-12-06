//
//  Mediator
//

// Chat User

protocol ChatUser: AnyObject {
    func enter(chat: Chat)
    func leaveChat()
    func send(message: String)
    func notify(message: String)
}

class NamedChatUser: ChatUser {
    private let name: String
    private weak var chat: Chat?
    
    init(name: String) {
        self.name = name
    }
    
    func enter(chat: Chat) {
        self.chat = chat
    }
    
    func leaveChat() {
        chat = nil
    }
    
    func send(message: String) {
        chat?.send(message: "\(name): \(message)", sender: self)
    }
    
    func notify(message: String) {
        print(message)
    }
}

// Chat

protocol Chat: AnyObject {
    func send(message: String, sender: ChatUser)
}

class ChatBetween2Users: Chat {
    private weak var user1: ChatUser?
    private weak var user2: ChatUser?
    
    func set(user1 user: ChatUser) {
        user.enter(chat: self)
        self.user1 = user
    }
    
    func set(user2 user: ChatUser) {
        user.enter(chat: self)
        self.user2 = user
    }
    
    func send(message: String, sender: ChatUser) {
        if sender === user1 {
            user2?.notify(message: message)
        } else if sender === user2 {
            user1?.notify(message: message)
        }
    }
}

// Client

class Client {
    func run() {
        let robert = NamedChatUser(name: "Robert")
        let сhris = NamedChatUser(name: "Chris")
        
        let chat = ChatBetween2Users()
        chat.set(user1: robert)
        chat.set(user2: сhris)
        
        robert.send(message: "How are you after yesterday's party?")
        сhris.send(message: "I remember nothing.")
    }
}

// Client().run()

// Robert: How are you after yesterday's party?
// Chris: I remember nothing.
