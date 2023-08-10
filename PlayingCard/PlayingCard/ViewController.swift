//
//  ViewController.swift
//  PlayingCard
//
//  Created by Vladimir Fibe on 07.08.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var deck = PlayingCardDeck()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

