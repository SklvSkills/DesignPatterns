//
//  Decorator
//

// Person

protocol Person {
    func introduceYourself() -> String
}

class BruceWayne: Person {
    func introduceYourself() -> String {
        "I'm Bruce Wayne."
    }
}

//  Decorator

class BatDecorator: Person {
    private let person: Person
    
    init(_ person: Person) {
        self.person = person
    }
    
    private func addPrefix() -> String {
        "In the afternoon: "
    }
    
    private func addPostfix() -> String {
        "\nAt night: I'm Vengeance! I'm the Night! I'm Batman!"
    }
    
    func introduceYourself() -> String {
        addPrefix() + person.introduceYourself() + addPostfix()
    }
}

// Client

class Client {
    func run() {
        let bruceWayne = BruceWayne()
        let batDecorator = BatDecorator(bruceWayne)
        print(batDecorator.introduceYourself())
    }
}

// Client().run()

// In the afternoon: I'm Bruce Wayne.
// At night: I'm Vengeance! I'm the Night! I'm Batman!
