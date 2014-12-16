//
//  FrenchCard.swift
//  Cards
//
//  Created by Valerio2 on 20/06/14.
//  Copyright (c) 2014 Valerio2. All rights reserved.
//

import Foundation

class FrenchCard : Card, Comparable {
    
    enum Suit : Int {
        
        case Cuori = 1
        case Quadri
        case Fiori
        case Picche
        
        func descr() -> String {
            switch self {
                
            case Cuori:
                return "♥️"
            case Quadri:
                return "♦️"
            case Fiori:
                return "♣️"
            case Picche:
                return "♠️"
            }
        }
        
        func color() -> String {
            switch self {
                
            case Cuori, Quadri:
                return "red"
            case Fiori, Picche:
                return "black"
            }
        }
    }
    
    enum Rank  {
        case N(Int)
        case J
        case Q
        case K
        case A
        
        init(_ n : Int) {
            
            // boundary check
            switch n {
            case 1:
                self = .A
            case 2...10:
                self = .N(n)
            case 11:
                self = .J
            case 12:
                self = .Q
            case 13:
                self = .K
            default:
                assertionFailure("impossible Rank value \(n)")
                break   // error
            }
        }
        
        func descr() -> String {
            switch self {
                
            case N(let x):
                return "\(x)"
            case J:
                return "J"
            case Q:
                return "Q"
            case K:
                return "K"
            case A:
                return "A"
            }
        }
        
        // questa serve per comparable (A vince)
        func number() -> Int {
            switch self {
                
            case N(let x):
                return x
            case J:
                return 11
            case Q:
                return 12
            case K:
                return 13
            case A:
                return 14
            }
        }
    }
    
    // importanti undescores per differenziarli da metodi
    private let _rank : Rank
    private let _suit : Suit
    
    init(var rank : Rank, var suit : Suit) {
        
        self._rank = rank
        self._suit = suit
        super.init()
        self.name = self.rank() + " " + self.suit()
    }
    
    //MARK: PUBLIC
    func suit() -> String {
        return _suit.descr()
    }
    
    func color() -> String {
        return _suit.color()
    }
    
    func rank() -> String {
        return _rank.descr()
    }
    
    override func descr() -> String {
        
        return super.descr()
        // return rank() + " " + suit()
    }
    
    func compare(card2 : FrenchCard) -> NSComparisonResult {
    
        let selfRank = self._rank.number()
        let card2Rank = card2._rank.number()
        
        var result : NSComparisonResult
        
        switch (selfRank, card2Rank) {

        case let (x, y) where x > y:
            result = .OrderedDescending
        case let (x, y) where x < y:
            result = .OrderedAscending
        default:
            result = self._suit.rawValue > card2._suit.rawValue ? .OrderedAscending : .OrderedDescending
        }
        
        /*if selfRank > card2Rank {
            
            result = .OrderedDescending
            
        } else if selfRank < card2Rank {
            
            result = .OrderedAscending
            
        } else {
            
            result = self.suitOrder > card2.suitOrder ? .OrderedAscending : .OrderedDescending
            
        }*/
        
        return result
    }
}

func <= (card1: FrenchCard, card2: FrenchCard) -> Bool {
    
    let res = card1.compare(card2)
    return res == .OrderedAscending
}

func >= (card1: FrenchCard, card2: FrenchCard) -> Bool {
    
    let res = card1.compare(card2)
    return res == .OrderedDescending
}

func < (card1: FrenchCard, card2: FrenchCard) -> Bool {
    
    let res = card1.compare(card2)
    return res == .OrderedAscending
}

func == (card1: FrenchCard, card2: FrenchCard) -> Bool {
    
    return false
}

