//
//  Chain of responsibility
//

// Translators

enum Language {
    case french, german, swedish
}

struct Task {
    let language: Language
    let text: String
}

protocol Translator: AnyObject {
    func translate(_ task: Task) -> String?
    var nextTranslator: Translator? { get set }
    
    @discardableResult
    func setNext(_ translator: Translator) -> Translator
}

extension Translator {
    func setNext(_ translator: Translator) -> Translator {
        nextTranslator = translator
        return translator
    }
}

class FrenchTranslator: Translator {
    var nextTranslator: Translator?
    
    func translate(_ task: Task) -> String? {
        guard task.language == .french else {
            return nextTranslator?.translate(task)
        }
        
        return task.text == "Bonjour le monde" ? "Hello World" : nil
    }
}

class GermanTranslator: Translator {
    var nextTranslator: Translator?
    
    func translate(_ task: Task) -> String? {
        guard task.language == .german else {
            return nextTranslator?.translate(task)
        }
        
        return task.text == "Hallo Welt" ? "Hello World" : nil
    }
}

class SwedishTranslator: Translator {
    var nextTranslator: Translator?
    
    func translate(_ task: Task) -> String? {
        guard task.language == .swedish else {
            return nextTranslator?.translate(task)
        }
        
        return task.text == "Hej världen" ? "Hello World" : nil
    }
}

// Client

class Client {
    func run() {
        let translator  = FrenchTranslator()
        let translator2 = GermanTranslator()
        let translator3 = SwedishTranslator()
        translator.setNext(translator2).setNext(translator3)
        
        let task = Task(language: .swedish, text: "Hej världen")
        
        guard let result = translator.translate(task) else {
            print("\"Translation not found.\"")
            return
        }
        
        print("\"\(task.text)\" -> \"\(result)\"")
    }
}

// Client().run()

// "Hej världen" -> "Hello World"
