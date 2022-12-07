//
//  State
//

protocol DocumentState {
    func publish()
}

class Draft: DocumentState {
    private let document: Document
    
    init(document: Document) {
        self.document = document
        print("The document is a draft state.")
    }
    
    func publish() {
        if document.user.isAdmin {
            document.change(state: Published(document: document))
        } else {
            document.change(state: Moderation(document: document))
        }
    }
}

class Moderation: DocumentState {
    private let document: Document
    
    init(document: Document) {
        self.document = document
        print("The document is in moderation.")
    }
    
    func publish() {
        document.change(state: Published(document: document))
    }
}

class Published: DocumentState {
    private let document: Document
    
    init(document: Document) {
        self.document = document
        print("The document has been published.")
    }
    
    func publish() {
        print("The document has already been published.")
    }
}

// Document

struct User {
    var isAdmin: Bool
}

class Document {
    private lazy var state: DocumentState = Draft(document: self)
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func change(state: DocumentState) {
        self.state = state
    }
    
    func publish() {
        state.publish()
    }
}

// Client

class Client {
    func run() {
        let document = Document(user: User(isAdmin: false))
        document.publish()
        document.publish()
        document.publish()
    }
}

// Client().run()

// The document is a draft state.
// The document is in moderation.
// The document has been published.
// The document has already been published.
