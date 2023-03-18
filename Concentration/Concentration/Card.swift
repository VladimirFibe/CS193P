import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory-1
    }
    
    init() {
        self.identifier = Self.getUniqueIdentifier()
    }
}
