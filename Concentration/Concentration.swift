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
    var score = 0
    var isGameComplete = false

    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfCards: Int){
        let numberOfCardPairs = numberOfCards % 2 == 0 ? numberOfCards / 2 : (numberOfCards + 1) / 2
        for _ in 0..<numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            //If indexOfOneAndOnlyFaceUpCard is set, then this is the 2nd card being turned over
            //so we need to check for a match. Otherwise turn all cards face down
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                    checkIfGameComplete()
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    if cards[flipDownIndex].isFaceUp {
                        if !cards[flipDownIndex].isMatched && cards[flipDownIndex].hasBeenFlippedAtLeastOnce {
                            score -= 1
                        }
                        cards[flipDownIndex].hasBeenFlippedAtLeastOnce = true
                        cards[flipDownIndex].isFaceUp = false;
                    }
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp = true
        }
    }
    
    func checkIfGameComplete() {
        for card in cards {
            if !card.isMatched {
                isGameComplete = false
                return
            }
        }
        isGameComplete = true
    }
}
