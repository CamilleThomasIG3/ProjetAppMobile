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
import Combine

struct AccueilView: View {//ok
    var cats = ["All","Date", "Fréquence", "Catégorie"]
    @State private var selectedCat = 0
    var estConnecte : Bool


    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named : "Turquoise")
        estConnecte = (UIApplication.shared.delegate as! AppDelegate).estConnecte
    }
    
    var body: some View {//ok
        VStack{//ok
            NavigationView{//ok
                VStack(alignment: .center, spacing: 20){ //ok
                    VStack{ //ok
                        HStack{
                            Picker(selection: $selectedCat, label: Text("Catégorie")) {
                                ForEach(0 ..< cats.count){
                                    Text(self.cats[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }.padding(10)

                        HStack(alignment: .firstTextBaseline) {
                            Text("Remarques sexistes").padding(.leading, 10)
                            
                            Spacer()
                            Text("Fréquences").padding(.trailing, 10)
                        }.background(Color(UIColor(named: "Gris_clair")!)).padding(10)
                    }//ok
                    List{//ok
                        HStack(alignment: .firstTextBaseline, spacing: 20){
                            Text("remarque1")
                            Spacer()
                            Text("3")
                        }
                        Text("remarque2")
                        Text("remarque3")
                    }//ok
                    HStack{ //ok
                        NavigationLink(destination: AjoutRemarqueView()){
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 200, height:30)
                                Text("Ajouter une remarque").foregroundColor(Color.black).padding(5)
                            }
                        }
//                        VStack{
//                            if(estConnecte){
//                                NavigationLink(destination: nil){
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 200, height:30)
//                                        Text("Mes contributions").foregroundColor(Color.black).padding(5)
//                                    }
//                                }
//                            }
//                        }
                    }//ok
                }.navigationBarTitle("Accueil", displayMode: .inline) //ok 2e vstack
                    .navigationBarItems(leading:
                        HStack{//ok
                            if(!estConnecte){
                                NavigationLink(destination: InscriptionView()){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Inscription").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }else{
                                //ATTENTION DECONNEXION MARCHE PAS !!
                                NavigationLink(destination: AccueilView()){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 120, height:30)
                                        Text("Déconnexion").foregroundColor(Color.black).padding(5)
                                    }
                                }.simultaneousGesture(TapGesture().onEnded({
                                    (UIApplication.shared.delegate as! AppDelegate).estConnecte = false
                                }))
                            }
                        }, trailing ://ok
                        HStack{//ok
                            if(!estConnecte){
                                NavigationLink(destination: ConnexionView()){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Connexion").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }else{
                                NavigationLink(destination: ProfilView()){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Profil").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }

                        }//ok
                )
            }.background(Color("Turquoise"))//ok
        }//ok
    }//ok
}//ok


struct AccueilView_Previews: PreviewProvider {
    static var previews: some View {
        AccueilView()
    }
}

