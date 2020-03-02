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

struct AccueilView: View {
    var cats = ["Date", "Fréquence", "Catégorie"]
    @State private var selectedCat = 0
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named : "Turquoise")
        
    }
    var body: some View {
        VStack{
            NavigationView{
                VStack(alignment: .center, spacing: 20){
                     HStack(alignment: .firstTextBaseline) {
                        Text("Remarques sexistes").padding(.leading, 10)
                        
//                        Picker(selection: $selectedCat, label: Text("Catégorie")) {
//                            ForEach(0 ..< cats.count){
//                                Text(self.cats[$0])
//                            }
//                        }
                        Spacer()
                        Text("Fréquences").padding(.trailing, 10)
                        }.background(Color(UIColor(named: "Gris_clair")!)).padding(10)
                     
                     List{
                         HStack(alignment: .firstTextBaseline, spacing: 20){
                             Text("remarque1")
                             Text("3")
                         }
                             Text("remarque2")
                             Text("remarque3")
                         }
                     NavigationLink(destination: ConnexionView()){
                         Text("Ajouter une remarque")
                     }.buttonStyle(PlainButtonStyle()).padding(10)
                }.navigationBarTitle("Accueil", displayMode: .inline)
                    .navigationBarItems(leading:
                        HStack{
                            NavigationLink(destination: ProfilView()){
                                Text("Inscription")
                            }.buttonStyle(PlainButtonStyle()).padding(10)
                            }, trailing :
                        HStack{
                            NavigationLink(destination: ConnexionView()){
                                
                                Text("Connexion")
                                //Image("sign_in").resizable().frame(width: 20, height: 20)
                            }.buttonStyle(PlainButtonStyle()).padding(10)
                        }
                    )
            }.background(Color("Turquoise"))
            }
        }
    }


struct AccueilView_Previews: PreviewProvider {
    static var previews: some View {
        AccueilView()
    }
}

