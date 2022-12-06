//
//  Command
//

// Toggle Switch

enum State: String {
    case on, off
}

protocol ToggleSwitch {
    func getState() -> State
    func set(_ newState: State)
}

// Commands

protocol Command {
    func execute()
}

class SwithOn: Command {
    private let toggleSwitch: ToggleSwitch
    
    init(_ toggleSwitch: ToggleSwitch) {
        self.toggleSwitch = toggleSwitch
    }
    
    func execute() {
        guard toggleSwitch.getState() != .on else {
            return
        }
        
        toggleSwitch.set(.on)
    }
}

class SwithOff: Command {
    private let toggleSwitch: ToggleSwitch
    
    init(_ toggleSwitch: ToggleSwitch) {
        self.toggleSwitch = toggleSwitch
    }
    
    func execute() {
        guard toggleSwitch.getState() != .off else {
            return
        }
        
        toggleSwitch.set(.off)
    }
}

// Invoker

class Invoker {
    private lazy var commands = [String: Command]()
    
    func setCommand(_ title: String, command: Command) {
        commands[title] = command
    }
    
    func executeCommand(_ title: String) {
        print("Command: \(title)")
        
        guard let command = commands[title] else {
            print("Command not found")
            return
        }
        
        command.execute()
    }
}

// Torch

class Torch: ToggleSwitch {
    private var state: State = .off
    
    func getState() -> State {
        state
    }
    
    func set(_ newState: State) {
        state = newState
        print("Torch \(newState.rawValue)")
    }
}

// Client

class Client {
    func run() {
        let torch = Torch()
        let torchSwithOn = SwithOn(torch)
        let torchSwithOff = SwithOff(torch)
        
        let lightsOn = "Turn on the lights"
        let lightsOff = "Turn off the lights"
        let lightsToggle = "Toggle the light"
        
        let invoker = Invoker()
        invoker.setCommand(lightsOn, command: torchSwithOn)
        invoker.setCommand(lightsOff, command: torchSwithOff)
        
        invoker.executeCommand(lightsOn)
        invoker.executeCommand(lightsOff)
        invoker.executeCommand(lightsToggle)
    }
}

// Client().run()

// Command: Turn on the lights
// Torch on
// Command: Turn off the lights
// Torch off
// Command: Toggle the light
// Command not found
