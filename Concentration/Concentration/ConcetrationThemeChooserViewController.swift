import UIKit

class ConcetrationThemeChooserViewController: UIViewController {
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒🏑🥍🏏🪃🛼🥊⛸️",
        "Animals": "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐵🐔🐧🐦",
        "Faces": "😀😃😄😁😆😅🥹😂🤣🥲☺️😊🙂🙃😉🥰😍😌😘"
    ]

    @IBAction func changeTheme(_ sender: UIButton) {
        performSegue(withIdentifier: "Choose Theme", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme",
            let button = sender as? UIButton,
           let title = button.currentTitle,
            let theme = themes[title],
           let controller = segue.destination as? ConcentrationViewController {
            controller.theme = theme
        }
    }
}
