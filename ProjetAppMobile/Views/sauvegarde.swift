//
//  ContentView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/23/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView2: View {
    
    
    var body: some View {
        VStack{
//            NavigationView{
                ZStack{
                    Rectangle().fill(Color(UIColor(named: "Turquoise")!)).frame(height:40)
                    HStack{
                        NavigationLink(destination: InscriptionView()){
                            Text("Inscription")
                        }.buttonStyle(PlainButtonStyle()).padding(10)
                        
                        Spacer()
                        Text("Accueil")
                        Spacer()
                        
                        NavigationLink(destination: ConnexionView()){
                            Text("Connexion")
                        }.buttonStyle(PlainButtonStyle()).padding(10)
                    }
                }
                    
            
            VStack(alignment: .center, spacing: 20){
                HStack(alignment: .firstTextBaseline, spacing: 150) {
                    Text("Remarques sexistes")//.multilineTextAlignment(.leading)
                    Text("Fréquences")//.multilineTextAlignment(.trailing)
                }.background(Color(UIColor(named: "Gris_clair")!))
                
                List{
                    HStack(alignment: .firstTextBaseline, spacing: 20){
                        Text("remarque1")
                        Text("3")
                    }
                        Text("remarque2")
                        Text("remarque3")
                    }
              //  NavigationLink(destination: AddRemarkView()){
           //         Text("add")
             //   }.buttonStyle(PlainButtonStyle()).padding(10)
                HStack{
                    NavigationLink(destination: AjoutReponseView()){
                                          Text("addRepTest")
                    }.buttonStyle(PlainButtonStyle()).padding(10)
                }
            }
//            }
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

