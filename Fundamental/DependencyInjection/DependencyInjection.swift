//
//  Dependency injection
//

// Game

protocol Game {
    func start(player: String)
}

class Chess: Game {
    func start(player: String) {
        print("\(player) started playing chess.")
    }
}

// Class without dependency injection

class ChessPlayer {
    private let name: String
    private let game: Game
    
    init(name: String) {
        self.name = name
        game = Chess()
    }
    
    func play() {
        game.start(player: name)
    }
}

// Classes with dependency injection

// Initializer injection

class Player1 {
    private let name: String
    private let game: Game
    
    init(name: String, game: Game) {
        self.name = name
        self.game = game
    }
    
    func play() {
        game.start(player: name)
    }
}

// Property injection

class Player2 {
    private let name: String
    var game: Game?
    
    init(name: String) {
        self.name = name
    }
    
    func play() {
        game?.start(player: name)
    }
}

// Method injection

class Player3 {
    private let name: String
    private var game: Game?
    
    init(name: String) {
        self.name = name
    }
    
    func add(game: Game) {
        self.game = game
    }
    
    func play() {
        game?.start(player: name)
    }
}

// Interface injection

class Player4 {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

protocol PlayChess {
    var name: String { get }
    func playChess()
}

extension Player4: PlayChess {
    func playChess() {
        let chess = Chess()
        chess.start(player: name)
    }
}

// Client

class Client {
    func run() {
        // Without injection
        let chessPlayer = ChessPlayer(name: "Ray")
        chessPlayer.play()
        
        // Initializer injection
        let chess1 = Chess()
        let player1 = Player1(name: "Magnus", game: chess1)
        player1.play()
        
        // Property injection
        let chess2 = Chess()
        let player2 = Player2(name: "Alireza")
        player2.game = chess2
        player2.play()
        
        // Method injection
        let chess3 = Chess()
        let player3 = Player3(name: "Fabiano")
        player3.add(game: chess3)
        player3.play()
        
        // Interface injection
        let player4 = Player4(name: "Gukesh")
        player4.playChess()
    }
}

// Client().run()

// Ray started playing chess.
// Magnus started playing chess.
// Alireza started playing chess.
// Fabiano started playing chess.
// Gukesh started playing chess.
