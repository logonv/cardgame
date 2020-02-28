import UIKit
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

class deck {
    
    var deckOfCards: [card]
    
    init() {
        self.deckOfCards = [card]()
        for rank in Rank.allValues{
            for suit in Suit.allValues{
                self.deckOfCards.append(card(rank:rank, suit: suit))
            }
        }
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
    
    func totalBlackJackHand()-> Int{
        var total=0
        for card in self.deckOfCards{
            total = total + card.rank.simpleAceHighValue()
    
        }
        
        if total>21{
            for card in self.deckOfCards{
                if card.rank.rawValue == 1  {
                    total=total-10
                    if total<=21{
                        break
                    }
                }
                
                
            }
            
        }
        
        return total
    }
    
    func checkIfBust() -> Bool{
        return self.totalBlackJackHand()>21
    }

    
    
}





var deck1=deck()
deck1.showFullDeck()

