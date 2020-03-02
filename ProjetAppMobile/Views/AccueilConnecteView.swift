//
//  AccueilConnecte.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/1/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct AccueilConnecteView: View {
    var cats = ["Date", "Fréquence", "Catégorie"]
    @State private var selectedCat = 0
        
    var body: some View {
        VStack{
            
            NavigationView{
                VStack(alignment: .center, spacing: 20){
                      
                                            
                    HStack(alignment: .firstTextBaseline, spacing: 150) {
                        Text("Remarques sexistes")
//                        Picker(selection: $selectedCat, label: Text("Catégorie")) {
//                            ForEach(0 ..< cats.count){
//                                Text(self.cats[$0])
//                            }
//                        }.pickerStyle(DefaultPickerStyle())
    
                        Text("Fréquences")
                    }.background(Color(UIColor(named: "Gris_clair")!))
                         
                    List{
                        HStack(alignment: .firstTextBaseline, spacing: 20){
                            Text("remarque1")
                            Text("3")
                        }
                        Text("remarque2")
                        Text("remarque3")
                    }
                    HStack {
                        NavigationLink(destination: ProfilView()){
                            Text("Mes contributions")
                        }.buttonStyle(PlainButtonStyle()).padding(10)
                        NavigationLink(destination: AjoutRemarqueView()){
                            Text("Ajouter une remarque")
                        }.buttonStyle(PlainButtonStyle()).padding(10)
                        
                    }
                }.navigationBarTitle("Accueil")
                .navigationBarItems(leading:
                    HStack{
                        NavigationLink(destination: AccueilView()){
                            Text("Déconnexion")
                        }.buttonStyle(PlainButtonStyle()).padding(10)
                    }, trailing :
                    HStack{
                        NavigationLink(destination: ProfilView()){
                            Text("Profil")
                        }.buttonStyle(PlainButtonStyle()).padding(10)
                    })
                }
            }
        }
}

struct AccueilConnecteView_Previews: PreviewProvider {
    static var previews: some View {
        AccueilConnecteView()
    }
}
