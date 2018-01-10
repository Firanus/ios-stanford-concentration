//
//  Concentration.swift
//  Concentration
//
//  Created by Ivan Tchernev on 10/01/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfCardPairs: Int){
        for _ in 1..<numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
    }
    
    func chooseCard(at index: Int){
        //Flip the card over
        if !cards[index].isMatched {
            cards[index].isFaceUp = !cards[index].isFaceUp
            
            //If indexOfOneAndOnlyFaceUpCard is set, then this is the 2nd card being turned over
            //so we need to check for a match. Otherwise turn all cards face down
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false;
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp = true
        }
    }
}
