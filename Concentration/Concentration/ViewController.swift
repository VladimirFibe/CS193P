import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    var emojiChoices = ["👻", "🎃", "🎃", "👻"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = buttons.firstIndex(of: sender) {
            flipCart(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }
    
    private func flipCart(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

