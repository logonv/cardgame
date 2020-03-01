//
//  test.swift
//  cardgame
//
//  Created by Logan Vasudeva on 01/03/2020.
//  Copyright © 2020 Logan Vasudeva. All rights reserved.
//

import SwiftUI

struct test: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
        HStack{
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .position(x: geometry.size.width/2, y: 2*geometry.size.height/3)
        }
    
        
            }
            
        }
    }
    
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
