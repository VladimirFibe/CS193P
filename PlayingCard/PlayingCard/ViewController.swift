
import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    @IBOutlet weak var playingCardVew: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(
                target: self,
                action: #selector(nextCard)
            )
            swipe.direction = [.left, .right]
            playingCardVew.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardVew, action: #selector(playingCardVew.adjustFaceCardScale))
            playingCardVew.addGestureRecognizer(pinch)
        }
    }

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        playingCardVew.isFaceUp.toggle()
    }
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardVew.rank = card.rank.order
            playingCardVew.suit = card.suit.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

