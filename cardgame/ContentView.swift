//
//  ContentView.swift
//  cardgame
//
//  Created by Logan Vasudeva on 27/02/2020.
//  Copyright © 2020 Logan Vasudeva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //@State var card1: card = card(rank: .joker, suit: .clubs)
    //@State var card2: card = card(rank: .joker, suit: .clubs)
    //@State var card3: card = card(rank: .joker, suit: .clubs)
    @State var dealerhand: [card] = []
    @State var playerhand: [card] = []
    var deck1: deck = deck()

    @State var playerChips: Int = 90

    @State var playerName: String = "Player Name"
    @State var amounttobet: Int = 50
    @State var betamount: Int = 50
    @State var slidervalue: Double = 50.0
    @State var betAllowed: Bool = false
    @State var showBetAlert: Bool = false
    @State var playerHasBet: Bool = false
    @State var alreadyBetAlert: Bool=false
    @State var cardsdealt: Bool = false
    @State var showdealerhandbool: Bool = false
    @State var doingInitialDeal: Bool=true
    @State var playerAskingForCards: Bool = false
    
    func checkBetAllowedReturnBet( bet: Int, remainingChips: Int) -> Int{
        
        if bet<=remainingChips{
            betAllowed=true
        }
        else{
            betAllowed=false
        }
        return bet
    }
  
    func slidervaluetoamounttobet()-> Bool{
        amounttobet=Int(slidervalue)
        return true
    }
   
    
    
    
    func initialDeal(){
        self.deck1.resetDeck()
        self.dealerhand=[]
        self.playerhand=[]
        self.playerhand.append(self.deck1.dealCard())
        self.playerhand.append(self.deck1.dealCard())
        self.dealerhand.append(self.deck1.dealCard())
        self.dealerhand.append(self.deck1.dealCard())
        self.playerAskingForCards=true
        self.amounttobet=Int(self.slidervalue)
    }
    
    func totalBlackJackHand( hand: Array<card>)-> Int{
        var total=0
        for card in hand{
            total = total + card.rank.simpleAceHighValue()
        }
        if total>21{
            for card in hand{
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
    
    func checkIfBust(hand: Array<card>) -> Bool{
        return self.totalBlackJackHand(hand: hand)>21
       }
    
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                    if self.cardsdealt == true{
                        if showdealerhandbool == false{
                            Text("back of card")
                        }
                        else{
                            Text(self.dealerhand[0].simpleDescription())
                        }
                        
                        ForEach(1..<dealerhand.count, id: \.self){
                            number in Text(self.dealerhand[number].simpleDescription())
                        }
                    }
                }
                
                if alreadyBetAlert==false{
                    Button(action: {
                    print("bet pressed")
                        if self.playerHasBet==false{
                            self.alreadyBetAlert=false
                            self.checkBetAllowedReturnBet(bet: self.amounttobet, remainingChips: self.playerChips)
                            if self.betAllowed == true{
                                self.playerChips = self.playerChips - self.amounttobet
                                self.betamount=self.amounttobet
                                self.playerHasBet=true
                                self.playerAskingForCards=true
                                self.alreadyBetAlert=true
                                if self.doingInitialDeal == true{
                                    self.initialDeal()
                                    self.cardsdealt = true
                                    self.doingInitialDeal = false
                                    
                                }
                                
                            }
                            else{
                                self.showBetAlert=true
                            }
                            
                        }
                        else{
                            self.alreadyBetAlert=true
                            
                        }
                        
                    }) {Text("Bet")}
                        .alert(isPresented: $showBetAlert) { () -> Alert in
                            Alert(title: Text("You do not have enough chips. Choose another amount"), dismissButton: .default(Text("Dismiss")))
                        }
                    
                }
                    /*
                    .alert(isPresented: $alreadyBetAlert) { () -> Alert in
                        Alert(title: Text("You  have already bet."), dismissButton: .default(Text("Dismiss")))
                }
 */
 
                
                
                Button(action: {
                    print("Shuffle pressed")
                    self.deck1.shuffleDeck()
                    }) {Text("Shuffle")}

                
                /*
                Button(action: {
                    print("Deal pressed")
                    if self.doingInitialDeal == true{
                        self.initialDeal()
                        self.cardsdealt = true
                        self.doingInitialDeal = false
                    }
                }) {Text("Deal")}

                 */
                
                Button(action: {
                print("show dealer hand pressed")
                self.showdealerhandbool.toggle() // = true
                //self.card1=self.deck1.dealCard()
                }) {Text("Show dealer hand")}
                
                /*
                Button(action: {
                print("clear hand")
                self.dealerhand=[]
                self.cardsdealt=false
                //self.showdealerhandbool.toggle() // = true
                //self.card1=self.deck1.dealCard()
                }) {Text("clear hand")}
                */
                
                Button(action: {
                print("reset game")
                    self.cardsdealt=false
                    self.alreadyBetAlert=false
                    self.showBetAlert=false
                    self.playerHasBet=false
                    self.playerAskingForCards=false

                    
                    self.deck1.resetDeck()
                    self.dealerhand=[]
                    self.playerhand=[]
                    self.doingInitialDeal=true
                    //self.deck1.buildDeck()
                    //self.showdealerhandbool.toggle() // = true
                }) {Text("reset game")}
                
                
                
                HStack{
                    Text("Cards left: " + String(self.deck1.numberOfCards()))
                }
                
                HStack{
                    if self.cardsdealt == true{
                        ForEach(0..<playerhand.count, id: \.self){
                            number in Text(self.playerhand[number].simpleDescription())
                        }
                    }
                }
                
                HStack{
                    Button(action: {
                        if self.playerAskingForCards==true{
                            self.playerhand.append(self.deck1.dealCard())
                            if self.checkIfBust(hand: self.playerhand)==true{
                                print("bust")
                                
                                self.cardsdealt=false
                                self.alreadyBetAlert=false
                                self.showBetAlert=false
                                self.playerHasBet=false
                                self.playerAskingForCards=false
                                self.deck1.resetDeck()
                                self.dealerhand=[]
                                self.playerhand=[]
                                self.doingInitialDeal=true
                            }
                        }
                        
                    }) {
                        Text("Hit")
                    }
                    
                    Button(action: {
                        self.playerAskingForCards=false
                    }) {
                        Text("Stick")
                    }
                    Text("Total hand " + String(totalBlackJackHand(hand: playerhand)) )
                    
                }
               
                
                VStack {
                    VStack{
                    Text("Player name " + self.playerName)
                    Text("Chips " + String(self.playerChips))
                    Text("Bet amount" + String(betamount))
                    Text("Bool check")
                    Text("Check if bust " + String(checkIfBust(hand: playerhand)))
                    Text("showdealerhandbool " + String(self.showdealerhandbool))
                    Text("cardsdealt " + String(self.cardsdealt))
                        Text("doingInitialDeal " + String(self.doingInitialDeal))
                        
                    }
                    VStack{
                    Text("Bet allowed " + String(self.betAllowed))
                    Text("Amount to bet " + String(self.amounttobet))
                    Text("Show bet alert" + String(self.showBetAlert))
                    Text("Player has bet " + String(self.playerHasBet))
                    Text("ALready bet alert " + String(self.alreadyBetAlert))
                    Text("cardsdealt " + String(self.cardsdealt))
                    Text("showerdealerhandbool " + String(self.showdealerhandbool))
                    Text("doing inital deal " + String(self.doingInitialDeal))
                    Text("player asking for cards " + String(playerAskingForCards))
                    }
                         
                    HStack{
                        Text("0")
                        Slider(value: $slidervalue, in: 0...100, step: 0.1, onEditingChanged:{_ in self.amounttobet=Int(self.slidervalue)} )
                
                        //self.amounttobet=Int(slidervalue)
                        Text("100")
                    }
                }
 
              
                
            }//end of VStack
            
            
        }//end of ZStack
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

extension Text {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
