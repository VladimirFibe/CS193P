import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    var playingCardView = PlayingCardView()

    @objc func flipCard(_ sender: UITapGestureRecognizer) {
        playingCardView.isFaceUp.toggle()
    }

    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.card = card
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayingCardView()
        setupConstraints()
    }
}

extension ViewController {
    private func setupPlayingCardView() {
        view.addSubview(playingCardView)
        view.backgroundColor = .systemOrange
        playingCardView.translatesAutoresizingMaskIntoConstraints = false
        let swipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(nextCard)
        )
        swipe.direction = [.left, .right]
        playingCardView.addGestureRecognizer(swipe)
        let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale))
        playingCardView.addGestureRecognizer(pinch)
    }

    private func setupConstraints() {
        let playingCardViewWidth = playingCardView.widthAnchor.constraint(equalToConstant: 800)
        playingCardViewWidth.priority = .defaultLow
        NSLayoutConstraint.activate([
            playingCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playingCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playingCardViewWidth,
            playingCardView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            playingCardView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            playingCardView.widthAnchor.constraint(equalTo: playingCardView.heightAnchor, multiplier: 5 / 8)
        ])
    }
}

