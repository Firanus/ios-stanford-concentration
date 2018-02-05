//
//  GameTheme.swift
//  Concentration
//
//  Created by Ivan Tchernev on 11/01/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import Foundation
import UIKit

enum GameTheme: Int {
    
    case Halloween
    case Sports
    case Religion
    case Japan
    
    static let count: Int = {
        var max: Int = 0
        while let _ = GameTheme(rawValue: max) { max += 1 }
        return max
    }()
    
    var primaryColor: UIColor {
        switch(self) {
        case .Halloween:
            return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case .Japan:
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case .Sports:
            return #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        case .Religion:
            return #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        }
    }
    
    var secondaryColor: UIColor {
        switch(self) {
        case .Halloween:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .Japan:
            return #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        case .Sports:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .Religion:
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }
    }
    
    var emojiChoices: String {
        switch(self) {
        case .Halloween:
            return "🦇😱🙀😈🎃👻🍭🍬🍎"
        case .Japan:
            return "🍶🥋⛩🇯🇵🔰🏯🎎🏣💴"
        case .Sports:
            return "⚽️🏀🏈⚾️🎾🏐🏹🏉🎱"
        case .Religion:
            return "🏛💒📿🙏⛩🕋🕍⛪️🕌"
        }
    }

}
