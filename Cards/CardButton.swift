//
//  CardButton.swift
//  Cards
//
//  Created by Valerio Ferrucci on 08/08/14.
//  Copyright (c) 2014 Valerio2. All rights reserved.
//

import UIKit

enum CardButtonPlayStatus {

    case Closed
    case Open
    case Current
    case Winner
    case Looser
}

class CardButton : UIButton {
    
    var playStatus : CardButtonPlayStatus = .Closed {
        
        willSet {
            
            switch newValue {
                
            case .Closed:
                self.setBackgroundImage(UIImage(named:"sfondo"), forState:.Normal)
                self.setTitle("", forState:.Normal)
                self.hidden = false;
                break;
                
            case .Open:
                self.setBackgroundImage(UIImage(named:"bianco"), forState:.Normal)
                self.hidden = false;
                break;
                
            case .Current:
                self.setBackgroundImage(UIImage(named:"corrente"), forState:.Normal)
                self.hidden = false;
                break;
                
            case .Winner:
                self.setBackgroundImage(UIImage(named:"vince"), forState:.Normal)
                self.hidden = false;
                break;
                
            case .Looser:
                self.hidden = true;
                break;
                
            }
        }
    }
    
    
}