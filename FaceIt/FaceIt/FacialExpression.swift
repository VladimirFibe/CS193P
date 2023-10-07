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

    var sadder: FacialExpression {
        FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }

    var happier: FacialExpression {
        FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }

    var eyes: Eyes
    var mouth: Mouth
}
