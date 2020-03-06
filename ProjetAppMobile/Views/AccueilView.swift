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

struct AccueilView: View {
    var cats = ["Date", "Fréquence", "Catégorie"]
    @State private var selectedCat = 0
    
    var estConnecte : Bool
    
    @ObservedObject var remarqueDAO = RemarqueDAO()

    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named : "Turquoise")
        estConnecte = (UIApplication.shared.delegate as! AppDelegate).estConnecte
    }
    
    var body: some View {
        VStack{
            NavigationView{
                VStack(alignment: .center, spacing: 20){
                    VStack{
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
                    }
                    
                    
                    List{
                        ForEach(remarqueDAO.remarques){
                            remarque in
                            HStack(alignment: .firstTextBaseline, spacing: 20){
                                Text(remarque.content)
                                Spacer()
                                Text("3")
                            }
                        }
                    }
                    
                    HStack{
                        if(estConnecte){
                            NavigationLink(destination: AccueilView()){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 200, height:30)
                                    Text("Mes contributions").foregroundColor(Color.black).padding(3)
                                }
                            }
                        }
                        
                        NavigationLink(destination: AjoutRemarqueView()){
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                                Text("Ajouter une remarque").foregroundColor(Color.black).padding(5)
                            }
                        }

                    }
                    
                }.navigationBarTitle("Accueil", displayMode: .inline)
                    .navigationBarItems(leading:
                        HStack{
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
                        }, trailing :
                        HStack{
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

