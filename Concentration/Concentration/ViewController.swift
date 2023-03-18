import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (buttons.count + 1) / 2)
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    var emojiChoices = ["👻", "🎃", "🤡", "💀", "🤖", "🤠", "😹", "😈"]
    var emoji: [Int: String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = buttons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in buttons.indices {
            let button = buttons[index]
            let card = game.cards[index]
            print(card.identifier)
            let emoji = emoji(for: card)
            if card.isFaceUp {
                button.setTitle(emoji, for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {

        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

