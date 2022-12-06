//
//  Memento
//

import Foundation

protocol Memento {
    var date: Date { get }
}

struct PinCodeMemento: Memento {
    let date = Date()
    let code: String
    
    init(_ code: String) {
        self.code = code
    }
}

// Originator

protocol Originator {
    func save() -> Memento
    func restore(memento: Memento)
}

class PinCodeOriginator: Originator {
    private(set) lazy var code = generateCode()
    
    private func generateCode() -> String {
        let code = Int.random(in: 0...9999)
        return String(format: "%04d", code)
    }
    
    func generateNewCode() {
        code = generateCode()
        print("Generated new PIN-Code")
    }
    
    func save() -> Memento {
        PinCodeMemento(code)
    }
    
    func restore(memento: Memento) {
        guard let memento = memento as? PinCodeMemento else {
            return
        }
        
        code = memento.code
    }
}

// Caretaker

class Caretaker {
    private lazy var mementos = [Memento]()
    private let originator: Originator
    
    init(for originator: Originator) {
        self.originator = originator
    }
    
    func backup() {
        let memento = originator.save()
        mementos.append(memento)
        print("Backup")
    }
    
    func undo() {
        guard !mementos.isEmpty else {
            return
        }
        
        let lastMemento = mementos.removeLast()
        originator.restore(memento: lastMemento)
        print("Undo")
    }
    
    func showList() {
        print("Caretaker List: [", terminator: "")
        
        for (index, memento) in mementos.enumerated() {
            print((index != 0 ? ", " : "") + "\(memento.date)", terminator: "")
        }
        
        print("]")
    }
}

// Client

class Client {
    func run() {
        let pinCode = PinCodeOriginator()
        print("PIN-Code: \(pinCode.code)")
        
        let caretaker = Caretaker(for: pinCode)
        caretaker.backup()
        caretaker.showList()
        
        pinCode.generateNewCode()
        print("PIN-Code: \(pinCode.code)")
        
        caretaker.undo()
        print("PIN-Code: \(pinCode.code)")
        caretaker.showList()
    }
}

// Client().run()

// PIN-Code: 5491
// Backup
// Caretaker List: [2022-12-06 14:00:15 +0000]
// Generated new PIN-Code
// PIN-Code: 6303
// Undo
// PIN-Code: 5491
// Caretaker List: []
