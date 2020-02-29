//
//  Test.swift
//  cardgame
//
//  Created by Logan Vasudeva on 29/02/2020.
//  Copyright © 2020 Logan Vasudeva. All rights reserved.
//

import SwiftUI

struct Test: View {
    @State var card1: card = card(rank: .five, suit: .clubs)
    var body: some View {
        HStack{
            Image("back")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            Image("back")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 100, minHeight: 50, idealHeight: 100, maxHeight: 100, alignment: .center)
            
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
