//
//  ContentView.swift
//  cardgame
//
//  Created by Logan Vasudeva on 27/02/2020.
//  Copyright © 2020 Logan Vasudeva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State var dealerhand: [card] = []
    @State var playerhand: [card] = []
    var deck1: deck = deck()
    
    @State var playerChips: Int = 90
    @State var playerChipsFloat: Float=0.0
    
    @State var playerName: String = "Player Name"
    @State var amounttobet: Int = 50
    @State var betamount: Int = 0
    @State var slidervalue: Double = 50.0
    @State var betAllowed: Bool = false
    @State var showBetAlert: Bool = false
    @State var playerHasBet: Bool = false
    @State var alreadyBetAlert: Bool=false
    @State var cardsdealt: Bool = false
    @State var showdealerhandbool: Bool = false
    @State var doingInitialDeal: Bool=true
    @State var playerAskingForCards: Bool = false
    @State var playerHasBustAlert: Bool = false
    @State var dealerPlaying: Bool = false
    @State var playerPlaying: Bool = false
    
    @State private var showingAlert = false
    @State var dealergoalert=false
    @State var result: String=" "
    
    @State var resultcase: Int=0
    // 1, dealer win, 2, player win, 3 draw
    
    func checkBetAllowedReturnBet( bet: Int, remainingChips: Int) -> Int{
        
        if bet<=remainingChips{
            betAllowed=true
        }
        else{
            betAllowed=false
        }
        return bet
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
        self.initialiseSliderParams()
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
    
    func initialiseSliderParams() {
        self.slidervalue = Double(self.playerChips / 2)
        self.amounttobet=Int(self.slidervalue)
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    
                    
                    VStack{
                        //dealer cards hstack
                        HStack{
                            if self.cardsdealt == true{
                                if self.showdealerhandbool == false{
                                    Image("back")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(minWidth: geometry.size.width/7, idealWidth: geometry.size.width/4, maxWidth: geometry.size.width/3, alignment: .center)
                                }
                                else{
                                    Image(self.dealerhand[0].simpleDescription())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(minWidth: geometry.size.width/7, idealWidth: geometry.size.width/4, maxWidth: geometry.size.width/3, alignment: .center)
                                }
                                
                                ForEach(1..<self.dealerhand.count, id: \.self){
                                    number in Image(self.dealerhand[number].simpleDescription())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(minWidth: geometry.size.width/7, idealWidth: geometry.size.width/4, maxWidth: geometry.size.width/3, alignment: .center)
                                }
                            }
                        }
                        if self.showdealerhandbool==true{
                            Text("Dealer's total is " + String(self.totalBlackJackHand(hand: self.dealerhand)))
                            
                        }
                        
                    }
                    //.position(x: geometry.size.width/2, y: geometry.size.height/5)
                    
                    
                    
                    HStack{
                        if self.cardsdealt == true{
                            ForEach(0..<self.playerhand.count, id: \.self){
                                number in Image(self.playerhand[number].simpleDescription())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(minWidth: geometry.size.width/7, idealWidth: geometry.size.width/4, maxWidth: geometry.size.width/3, alignment: .center)
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                    //totals stack
                    VStack{
                        if self.cardsdealt == true{
                            Text("Player's total is " + String(self.totalBlackJackHand(hand: self.playerhand)))
                            //Text("dealer Total hand " + String(totalBlackJackHand(hand: dealerhand)))
                            
                        }
                    }
                    
                    VStack {
                        
                        HStack{
                            if self.alreadyBetAlert==false {
                                Button(action: {
                                    print("bet pressed")
                                    if self.playerHasBet==false{
                                        self.alreadyBetAlert=false
                                        self.betamount=self.checkBetAllowedReturnBet(bet: self.amounttobet, remainingChips: self.playerChips)
                                        if self.betAllowed == true{
                                            self.playerChips = self.playerChips - self.betamount
                                            self.playerHasBet=true
                                            self.playerAskingForCards=true
                                            self.alreadyBetAlert=true
                                            self.playerHasBustAlert=false
                                            self.playerPlaying=true
                                            
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
                                }) {Text("Bet "+String(self.amounttobet))}
                                    .alert(isPresented: self.$showBetAlert) { () -> Alert in
                                        Alert(title: Text("You do not have enough chips. Choose another amount"), dismissButton: .default(Text("Dismiss")))
                                }
                            }
                            
                        }
                        
                        HStack{
                            
                            if self.cardsdealt==false{
                                //Spacer()
                                Text("0")
                                Slider(
                                    value: self.$slidervalue,
                                    in: 0...Double(self.playerChips > 10 ? self.playerChips : 10),
                                    step: 0.1,
                                    onEditingChanged:{_ in self.amounttobet=Int(self.slidervalue)}
                                )
                                Text(String(self.playerChips > 10 ? self.playerChips : 10))
                                Spacer()
                            }
                            
                        }
                        HStack{
                            Text("Chips: " + String(self.playerChips))
                            if self.alreadyBetAlert==true{
                                if self.resultcase == 0{
                                    Text("Bet amount: "+String(self.betamount))
                                }}
                        }
                        
                        HStack{
                            if self.playerPlaying==true{
                                Button(action: {
                                    if self.playerAskingForCards==true{
                                        self.playerhand.append(self.deck1.dealCard())
                                        if self.checkIfBust(hand: self.playerhand)==true{
                                            print("bust")
                                            
                                            self.playerHasBustAlert=true
                                            
                                            self.showBetAlert=false
                                            self.playerHasBet=false
                                            self.playerAskingForCards=false
                                            self.dealerPlaying=false
                                            self.betAllowed=true
                                            
                                        }
                                    }
                                }) {Text("Hit")}
                                    .alert(isPresented: self.$playerHasBustAlert) { () -> Alert in
                                        Alert(title: Text("You have bust"), dismissButton: .default(Text("Dismiss")){
                                            self.playerPlaying=false
                                            })
                                        
                                }
                                
                                //stick button
                                if self.playerPlaying==true{
                                    Button(action: {
                                        
                                        self.playerAskingForCards = false
                                        self.dealerPlaying = true
                                        self.playerPlaying=false
                                        self.showdealerhandbool = true
                                        
                                        
                                    }) {
                                        Text("Stick")
                                    }
                                    
                                }
                                
                            }
                            
                            if self.dealerPlaying==true{
                                Button(action: {
                                    
                                    if self.totalBlackJackHand(hand: self.dealerhand)<self.totalBlackJackHand(hand: self.playerhand){
                                        self.dealerhand.append(self.deck1.dealCard())
                                        if self.checkIfBust(hand: self.dealerhand)==true{
                                            print("bust")
                                            self.result = "Dealer has busted."
                                            self.resultcase=1
                                            
                                            
                                            self.dealergoalert=true
                                            
                                        }
                                        else if self.totalBlackJackHand(hand: self.dealerhand)==self.totalBlackJackHand(hand: self.playerhand){
                                            print("This is a split pot. Player does not lose anything")
                                            self.result="This is a split pot. Player does not lose anything."
                                            
                                            self.resultcase=3
                                            
                                            
                                            self.dealergoalert=true
                                        }
                                        else if self.totalBlackJackHand(hand: self.dealerhand)>self.totalBlackJackHand(hand: self.playerhand){
                                            print("dealer wins")
                                            self.result="The dealer wins."
                                            self.showBetAlert=false
                                            
                                            
                                            self.dealergoalert=true
                                            
                                        }
                                    }
                                    else if self.totalBlackJackHand(hand: self.dealerhand)==self.totalBlackJackHand(hand: self.playerhand){
                                        print("This is a split pot. Player does not lose anything")
                                        self.result="This is a split pot. Player does not lose anything."
                                        self.resultcase=3
                                        
                                        self.showBetAlert=false
                                        
                                        
                                        self.dealergoalert=true
                                    }
                                    else if self.totalBlackJackHand(hand: self.dealerhand)>self.totalBlackJackHand(hand: self.playerhand){
                                        print("dealer wins")
                                        self.result="The dealer wins."
                                        self.showBetAlert=false
                                        //self.alreadyBetAlert=false
                                        
                                        //self.dealerPlaying = false
                                        self.dealergoalert=true
                                        
                                        //self.alreadyBetAlert=false
                                    }
                                }) {
                                    Text("Show dealer's next move")
                                }
                                .alert(isPresented: self.$dealergoalert) { () -> Alert in
                                    Alert(title: Text("\(self.result)"), dismissButton: .default(Text("dismiss"), action: {
                                        if self.resultcase==1{
                                            self.playerChips=self.playerChips+2*self.betamount
                                            //self.resultcase=0
                                        }
                                        if self.resultcase==3{
                                            self.playerChips=self.playerChips+self.betamount
                                            //self.resultcase=0
                                        }
                                        self.initialiseSliderParams()
                                        self.dealerPlaying=false
                                    }))
                                }
                            }
                            
                            if self.playerPlaying == false && self.dealerPlaying == false && self.cardsdealt==true{
                                Button(action: {
                                    
                                    self.playerHasBustAlert=false
                                    self.showBetAlert=false
                                    self.playerHasBet=false
                                    self.playerAskingForCards=false
                                    self.betAllowed=true
                                    self.resultcase=0
                                    self.showdealerhandbool=false
                                    self.doingInitialDeal=true
                                    self.deck1.resetDeck()
                                    self.dealerhand=[]
                                    self.playerhand=[]
                                    self.alreadyBetAlert=false
                                    self.cardsdealt=false
                                    self.dealerPlaying=false
                                    print()
                                    
                                }) {
                                    Text("Clear table")
                                }
                            }
                        }
                        
                    }
                    
                }//end of VStack
                
            }//end of ZStack
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
