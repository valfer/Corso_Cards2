//
//  ViewController.swift
//  Cards
//
//  Created by Valerio2 on 19/06/14.
//  Copyright (c) 2014 Valerio2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var playerScoreLbl: UILabel!
    @IBOutlet weak var userScoreLbl: UILabel!
 
    @IBOutlet var userDeckButtons: [CardButton]!
    @IBOutlet var playerDeckButtons: [CardButton]!
    
    var deck = Deck()
    var userDeck = PlayingDeck()
    var playerDeck = PlayingDeck()
    var currentPlay = 0
    var playerScore = 0
    var userScore = 0
    
    @IBAction func restartGame(sender: AnyObject) {
        
        if currentPlay == userDeckButtons.count /* finito? */ {
            resetGame()
        } else {
            
            let alert:UIAlertController = UIAlertController(title: "Conferma", message: "Vuoi veramente interrompere il gioco e cominciarne un altro?", preferredStyle:.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                self.resetGame()
            }))
            alert.addAction(UIAlertAction(title: "Annulla", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            self.presentViewController(alert, animated:true, completion:nil);
        }
    }
    
    func resetGame() {
        
        // esempio di map
        userDeckButtons.map({$0.playStatus = .Closed})
        playerDeckButtons.map({$0.playStatus = .Closed})
        currentPlay = 0
        userScore = 0
        playerScore = 0
        updateScoreLbl()
        initGame()
    }
    
    private func updateScoreLbl() {
        
        userScoreLbl.text = String(userScore)
        playerScoreLbl.text = String(playerScore)
    }
    
    func showPlayAlert(title : String, message : String) {
        
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle:.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        self.presentViewController(alert, animated:true, completion:nil);
    }
 
    @IBAction func playWithCard(userCardButton: CardButton) {
        
        if userCardButton.playStatus == CardButtonPlayStatus.Open {
        
            stopUser()
            
            // gioco con questa carta
            userCardButton.playStatus = .Current;
            
            // trovo la carta dell'avversario corrispondente
            let currentUserCardIndex = find(self.userDeckButtons!, userCardButton)
            /* anche
            let array: NSArray = NSArray(objects: self.userDeckButtons)
            let currentUserCardIndex = array.indexOfObject(userCardButton)
            */
            let userCard = self.userDeck[currentUserCardIndex!] as FrenchCard
            
            // prendo una carta anche dal player e la mostro
            let playerCard  = self.playerDeck[self.currentPlay] as FrenchCard
            let playerButton = self.playerDeckButtons[self.currentPlay] as CardButton
            self.showCard(playerCard, button:playerButton)
            
            // play
            let res = playerCard > userCard // comparable
            
            let delay = 1.0 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
                println("dispatched")
                if res {
                    
                    playerButton.playStatus = .Winner;
                    self.playerScore++;
                    userCardButton.playStatus = .Looser;
                } else {
                    
                    playerButton.playStatus = .Looser;
                    userCardButton.playStatus = .Winner;
                    self.userScore++;
                }
                
                self.startUser()
                self.currentPlay++
                
                self.updateScoreLbl()
                
                // gioco finito?
                if self.currentPlay == self.userDeckButtons.count {
                    
                    var message = ""
                    var title = ""
                    switch (self.userScore, self.playerScore) {
                    
                    case let(u, p) where u > p:
                        message = "Hai vinto \(u) a \(p)!"
                        title = "😄"
                    case let(u, p) where u < p:
                        message = "Hai perso \(u) a \(p)!"
                        title = "😁"
                    default:
                        message = "Pari"
                        title = "😔"
                    }
                    self.showPlayAlert(title, message: message)
                }
            })
        }
    }

    func initGame() {

        stopUser()
        
        // mazzo globale
        for s in 1...4 {
            for n in 1...13 {
                let rank = FrenchCard.Rank(n)
                let suit : FrenchCard.Suit? = FrenchCard.Suit(rawValue: s)
                let card = FrenchCard(rank: rank, suit: suit ?? .Cuori)
                deck.addCard(card)
            }
        }
        
        // mazzo dello user
        let totCards = self.userDeckButtons.count;
        for var i = 0; i < totCards; i++ {
            
            let card = self.deck.drawRandomCard() as FrenchCard
            self.userDeck.addCard(card)
        }
        
        // mazzo del player
        let totPlayerCards = self.playerDeckButtons.count;
        for var i = 0; i < totPlayerCards; i++ {
            
            let card = self.deck.drawRandomCard() as FrenchCard
            self.playerDeck.addCard(card)
        }
        
        // scopro le carte dello user, una per una con un timer
        for (idx,userCardButton) in enumerate(userDeckButtons!) {
            
            let userInfo = ["cardButton" : userCardButton, "index" : idx]

            let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.5*Double(idx), target: self, selector: Selector("openUserCard:"), userInfo: userInfo, repeats: false)
        }
    }
    
    func stopUser() {
        
        for card in self.userDeckButtons {
            card.userInteractionEnabled = false
        }
    }
    
    func startUser() {
        
        for card in self.userDeckButtons {
            card.userInteractionEnabled = true
        }
    }

    func showCard(card : FrenchCard, button:CardButton) {
        
        let title = card.name
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(card.color() == "red" ? UIColor.redColor() : UIColor.blackColor(), forState:.Normal)
        button.playStatus = .Open;
    }

    func openUserCard(timer : NSTimer) {
        
        let cardButton = timer.userInfo!["cardButton"] as CardButton
        let index = timer.userInfo!["index"] as Int
        let card = self.userDeck[index] as FrenchCard
        
        self.showCard(card, button:cardButton)
        
        // è l'ultima?
        if index == self.userDeckButtons.count - 1 {
            startUser()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

