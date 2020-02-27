//
//  navTest.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/27/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct navTest: View {
    var body: some View {
        ZStack{
            Rectangle().fill(Color(UIColor(named: "Turquoise")!)).frame(height:40)
            HStack{
                Text("Inscription").padding(10)
                Spacer()
                Text("Accueil")
                Spacer()
                Text("Connexion").padding(10)
            }
        }
//        VStack{
//            .
//            HStack(){
//                Text("body")
//            }
//        }
    }
}

struct navTest_Previews: PreviewProvider {
    static var previews: some View {
        navTest()
    }
}
