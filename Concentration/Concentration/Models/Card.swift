import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    private static var identifierFactory = -1
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Self.getUniqueIdentifier()
    }
}
