//
//  Flyweight
//

import UIKit

// Char image

class CharImage {
    func render(_ char: Character, fontName: String, fontSize: CGFloat) -> UIImage {
        let image = UIImage()
        // rendering char
        return image
    }
}

// Flyweight factory

class CharImageFactory {
    private struct ID: Hashable {
        let char: Character
        let fontName: String
        let fontSize: CGFloat
    }
    
    private var cache = [ID: UIImage]()
    
    func get(_ char: Character, fontName: String, fontSize: CGFloat) -> UIImage {
        let id = ID(char: char, fontName: fontName, fontSize: fontSize)
        
        if let image = cache[id] {
            print("return cached '\(char)'")
            return image
        } else {
            let image = CharImage().render(char, fontName: fontName, fontSize: fontSize)
            cache[id] = image
            print("return rendered '\(char)'")
            return image
        }
    }
}

// Painter

class Painter {
    func draw(_ image: UIImage) {
        // drawing image
    }
}

// Client

class Client {
    func run() {
        let charImageFactory = CharImageFactory()
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        let fontName = bodyFont.fontName
        let fontSize = bodyFont.pointSize
        
        for char in "Cupertino, California" {
            let image = charImageFactory.get(char, fontName: fontName, fontSize: fontSize)
            Painter().draw(image)
        }
    }
}

// Client().run()

// return rendered 'C'
// return rendered 'u'
// return rendered 'p'
// return rendered 'e'
// return rendered 'r'
// return rendered 't'
// return rendered 'i'
// return rendered 'n'
// return rendered 'o'
// return rendered ','
// return rendered ' '
// return cached 'C'
// return rendered 'a'
// return rendered 'l'
// return cached 'i'
// return rendered 'f'
// return cached 'o'
// return cached 'r'
// return cached 'n'
// return cached 'i'
// return cached 'a'
