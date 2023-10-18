
import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()

    @IBOutlet var cardViews: [PlayingCardView]!

    var count: Int {
        (cardViews.count + 1) / 2
    }

    lazy var animator = UIDynamicAnimator(referenceView: view)

    lazy var cardBehavior = CardBehavior(in: animator)

    override func viewDidLoad() {
        super.viewDidLoad()
        var cards: [PlayingCard] = []
        for _ in 1...count {
            if let card = deck.draw() {
                cards += [card, card]
            }
        }
        for cardView in cardViews {
            cardView.isFaceUp = false
            cardView.frame.size.width = UIScreen.main.bounds.width / 5
            cardView.frame.size.height = cardView.frame.width * 8 / 5
            let index = Int.random(in: 0..<cards.count)
            let card = cards.remove(at: index)
            cardView.card = card
            let tap = UITapGestureRecognizer(target: self, action: #selector(flipCard))
            cardView.addGestureRecognizer(tap)
            cardBehavior.addItem(cardView)
        }
    }

    private var faceUpCardViews: [PlayingCardView] {
        cardViews.filter { $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) && $0.alpha == 1}
    }

    private var faceUpCardViewsMatch: Bool {
        let cards = faceUpCardViews
        return cards.count == 2 && cards[0].card == cards[1].card
    }

    var lastChosenCardView: PlayingCardView?

    @objc func flipCard(_ sender: UITapGestureRecognizer) {
        guard let chosenCardView = sender.view as? PlayingCardView,
        faceUpCardViews.count < 2 else { return }
        lastChosenCardView = chosenCardView
        switch sender.state {
        case .ended:
            cardBehavior.removeItem(chosenCardView)
            UIView.transition(
                with: chosenCardView,
                duration: 0.6,
                options: [.transitionFlipFromLeft],
                animations: { chosenCardView.isFaceUp.toggle() },
                completion: { finished in
                    let cardsToAnimate = self.faceUpCardViews
                    if self.faceUpCardViewsMatch {
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 0.6,
                            delay: 0,
                            animations: {
                                cardsToAnimate.forEach {
                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
                                }
                            },
                            completion: { position in
                                UIViewPropertyAnimator.runningPropertyAnimator(
                                    withDuration: 0.6,
                                    delay: 0,
                                    animations: {
                                        cardsToAnimate.forEach {
                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                            $0.alpha = 0
                                        }
                                    },
                                    completion: { position in
                                        cardsToAnimate.forEach {
                                            $0.isHidden = true
                                            $0.alpha = 1
                                            $0.transform = .identity
                                        }
                                    }
                                )
                            }
                        )
                    } else if cardsToAnimate.count == 2 {
                        if chosenCardView == self.lastChosenCardView {
                            cardsToAnimate.forEach { cardView in
                                UIView.transition(
                                    with: cardView,
                                    duration: 0.6,
                                    options: [.transitionFlipFromLeft],
                                    animations: {cardView.isFaceUp = false},
                                    completion: { finished in
                                        self.cardBehavior.addItem(cardView)
                                    }
                                )
                            }
                        }
                    } else {
                        if !chosenCardView.isFaceUp {
                            self.cardBehavior.addItem(chosenCardView)
                        }
                    }
                }
            )
        default: break
        }
    }
}

