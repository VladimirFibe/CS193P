import Foundation

struct FacialExpression {
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }

    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile

        var sadder: Mouth {
            Mouth(rawValue: rawValue - 1) ?? .frown
        }

        var happier: Mouth {
            Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }

    mutating func toggleEyes() {
        switch eyes {
        case .open: eyes = .closed
        default: eyes = .open
        }
    }

    mutating func increaseHappiness() {
        mouth = mouth.happier
    }

    mutating func decreaseHappiness() {
        mouth = mouth.sadder
    }

    var eyes: Eyes
    var mouth: Mouth
}
