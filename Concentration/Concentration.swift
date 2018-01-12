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
    private(set) var cards = [Card]()
    
    var isGameComplete: Bool {
        get {
            for card in cards {
                if !card.isMatched {
                    return false
                }
            }
            return true
        }
    }
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                if(cards[index].isFaceUp) {
                    //If we've had a repeated mismatch, decrease the score
                    if !cards[index].isMatched && cards[index].hasBeenFlippedAtLeastOnce {
                        score -= 1
                    }
                    cards[index].hasBeenFlippedAtLeastOnce = true
                }
                cards[index].isFaceUp = (index == newValue);
            }
        }
    }
    
    init(numberOfCards: Int){
        let numberOfCardPairs = numberOfCards % 2 == 0 ? numberOfCards / 2 : (numberOfCards + 1) / 2
        for _ in 0..<numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        
        //Shuffle the cards
        for k in stride(from: cards.count - 1, to: 0, by: -1) {
            cards.swapAt(Int(arc4random_uniform(UInt32(k + 1))), k)
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            //If we have a faceup card check for a match. Otherwise, update the index.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
