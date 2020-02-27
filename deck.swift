//
//  deck.swift
//  cardgame
//
//  Created by Logan Vasudeva on 27/02/2020.
//  Copyright © 2020 Logan Vasudeva. All rights reserved.
//

import Foundation

class deck {
    
    var deckOfCards: [card]
    
    init() {
        self.deckOfCards = [card]()
        for rank in Rank.allValues{
            for suit in Suit.allValues{
                self.deckOfCards.append(card(rank:rank, suit: suit))
            }
        }
        self.deckOfCards.removeLast()
        self.deckOfCards.removeLast()
        self.deckOfCards.removeLast()
        self.deckOfCards.removeLast()
    }
    func dealCard() -> card{
        return deckOfCards.removeLast()
        
    }
    
    func showFullDeck() -> String{
        var printList = " "
        for card in self.deckOfCards{
            printList.append(card.simpleDescription())
            printList.append(" ")
        }
        return printList
    }
    
    func emptyDeck(){
       self.deckOfCards = [card]()
    }
    func buildDeck(){
        self.deckOfCards = [card]()
        for rank in Rank.allValues{
            for suit in Suit.allValues{
                self.deckOfCards.append(card(rank:rank, suit: suit))
            }
        }
        self.deckOfCards.removeLast()
        self.deckOfCards.removeLast()
        self.deckOfCards.removeLast()
        self.deckOfCards.removeLast()
    }
    func shuffleDeck(){
        self.deckOfCards.shuffle()
        
    }
    func resetDeck(){
        self.buildDeck()
        self.shuffleDeck()
    }
    func numberOfCards() -> Int{
        return self.deckOfCards.count
        
    }
    
    func addCardToDeck( cardToAdd: card){
        self.deckOfCards.append(cardToAdd)
        
    }
    
    func showDealerHand()-> String{
        var printList = ""
        printList.append(self.deckOfCards[0].simpleDescription())
        printList.append(" The other card is hidden.")
        return printList
        
    }
  
    
    
}
