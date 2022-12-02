//
//  Facade
//

class CPU {
    func freeze() {
        print("Freezing processor")
    }
    
    func jump(position: String) {
        print("Jumping to: \(position)")
    }
    
    func execute() {
        print("Executing")
    }
}

class Memory {
    func load(position: String, data: String) {
        print("Loading from \(position) data: \(data)")
    }
}

class HardDrive {
    func read(lba: String, size: String) -> String {
        print("Reading data from sector \(lba) with size \(size)")
        return #""Some data""#
    }
}

// Facade

class ComputerFacade {
    private let cpu = CPU()
    private let memory = Memory()
    private let hardDrive = HardDrive()
    
    func start() {
        cpu.freeze()
        let data = hardDrive.read(lba: "100", size: "1024")
        memory.load(position: "0x00", data: data)
        cpu.jump(position: "0x00")
        cpu.execute()
    }
}

// Client

class Client {
    func run() {
        let pc = ComputerFacade()
        pc.start()
    }
}

// Client().run()

// Freezing processor
// Reading data from sector 100 with size 1024
// Loading from 0x00 data: "Some data"
// Jumping to: 0x00
// Executing
