//
//  Null object
//

// Mail server

protocol MailServer: AnyObject {
    func send(_ message: String, from email1: String, to email2: String)
}

// Contact

class Contact {
    let email: String
    weak var mailServer: MailServer?
    
    init(email: String) {
        self.email = email
    }
    
    func send(_ message: String, to email: String) {
        mailServer?.send(message, from: self.email, to: email)
    }
    
    func receive(_ message: String, from email: String) {
        print("Message from \(email) to \(self.email): \"\(message)\"")
    }
}

class NullContact: Contact {
    override func receive(_ message: String, from email: String) {
        send("Invalid email.", to: email)
    }
}

// Company server

class CompanyServer: MailServer {
    private lazy var nullObject: Contact = {
        let contact = NullContact(email: "bot@domain.com")
        contact.mailServer = self
        return contact
    }()
    
    private lazy var contacts = [String: Contact]()
    
    func add(contact: Contact) {
        contact.mailServer = self
        contacts[contact.email] = contact
    }
    
    private func getContact(by email: String) -> Contact {
        guard let contact = contacts[email] else {
            return nullObject
        }
        
        return contact
    }
    
    func send(_ message: String, from email1: String, to email2: String) {
        getContact(by: email2).receive(message, from: email1)
    }
}

// Client

class Client {
    func run() {
        let companyServer = CompanyServer()
        
        let patrick = Contact(email: "patrick@domain.com")
        companyServer.add(contact: patrick)
        
        let helen = Contact(email: "helen@domain.com")
        companyServer.add(contact: helen)
        
        patrick.send("Hello.", to: "elena@domain.com")
        patrick.send("Hello.", to: "helen@domain.com")
    }
}

// Client().run()

// Message from bot@domain.com to patrick@domain.com: "Invalid email."
// Message from patrick@domain.com to helen@domain.com: "Hello."
