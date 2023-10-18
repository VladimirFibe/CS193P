import Foundation

struct PlayingCard: CustomStringConvertible, Equatable {
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        lhs.rank.order == rhs.rank.order && lhs.suit == rhs.suit
    }

    var suit: Suit
    var rank: Rank
    var description: String {
        "\(rank)\(suit)"
    }
    
    var image: String {
        switch rank {
        case .face(let kind):
            switch suit {
            case .spades: return "S" + kind
            case .hearts: return "H" + kind
            case .diamonds: return "D" + kind
            case .clubs: return "C" + kind
            }
        default: return ""
        }
    }

    enum Suit: String, CustomStringConvertible {
        case spades = "♠️"
        case hearts = "❤️"
        case diamonds = "♦️"
        case clubs = "♣️"
        var description: String { self.rawValue }
        static let all = [Suit.spades, .hearts, .diamonds, .clubs]
    }

    enum Rank: CustomStringConvertible {
        case ace
        case face(String)
        case numeric(Int)
        var description: String {
            switch self {
            case .ace: return "A"
            case .numeric(let pips): return "\(pips)"
            case .face(let kind): return kind
            }
        }
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }

        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 { allRanks.append(Rank.numeric(pips))}
            allRanks += [.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
}
