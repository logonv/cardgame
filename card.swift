//
//  card.swift
//  cardgame
//
//  Created by Logan Vasudeva on 27/02/2020.
//  Copyright © 2020 Logan Vasudeva. All rights reserved.
//

import Foundation

enum Suit {
    case spades, hearts, diamonds, clubs
    
    static let allValues = [spades, hearts, diamonds, clubs]
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
}

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, joker
    
    static let allValues = [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, joker]

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        case .joker:
            return "joker"
        default:
            return String(self.rawValue)
        }
    }
    
    func simpleAceHighValue() -> Int{
        
        switch self {
        case .ace:
            return 11
        case .jack:
            return 10
        case .queen:
            return 10
        case .king:
            return 10
        default:
            return self.rawValue
        }
    }
}


struct card {
    
    let suit: Suit
    let rank: Rank
        
    init(rank: Rank, suit: Suit) {
          self.rank = rank
          self.suit = suit
        }
/*
    static var example: card{
        card(rank: .ace, suit: .spades)
        
    }
 */
   func simpleDescription() -> String {
    return "\(rank.simpleDescription())_of_\(suit.simpleDescription())"
    }
}
