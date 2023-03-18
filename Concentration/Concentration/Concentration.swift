import Foundation

class Concentration {
    var cards: [Card] = []
    var indexOfOneAndOnlyFaceUpCard: Int?
    func chooseCard(at index: Int) {
        guard !cards[index].isMatched else { return }
        if let matchIndex = indexOfOneAndOnlyFaceUpCard,
           matchIndex != index {
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
