//
//  PlayingDeck.swift
//  Cards
//
//  Created by Valerio Ferrucci on 08/08/14.
//  Copyright (c) 2014 Valerio2. All rights reserved.
//

import Foundation

class PlayingDeck : Deck {
    
    // subscript
    subscript(index: Int) -> Card {
        get {
            return self.cardAtIndex(index)
        }
    }
}