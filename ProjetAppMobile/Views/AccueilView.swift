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
    var cats = ["Récent", "Fréquence", "Catégorie", "Les miennes"]
    @State private var selectedCat = 0
    
    @State var estConnecte  = false
    @State private var showingAlert = false
    
    @ObservedObject var remarqueDAO = RemarqueDAO()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
            entity: PersonneApp.entity(),
            sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named : "Turquoise")
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
                                NavigationLink(destination: RemarqueDetailView(remarque : remarque)){
                                    Text(remarque.content)
                                    Spacer()
                                    Text(String(remarque.nbLikes)).padding(.trailing, 20)
                                }
                            }
                        }
                    }.onAppear {
                        self.remarqueDAO.getAllRemaques()
                        
//                        for e in self.myPersonne {
//                            self.managedObjectContext.delete(e)
//
//                            do {
//                                try self.managedObjectContext.save()
//                            } catch {
//                                fatalError()
//                            }
//                        }
                        
                        for e in self.myPersonne {
                            guard let z = e.pseudo else{
                                return
                            }
                            print(z)
                        }
                    }
                    
                    HStack{
                        if(estConnecte){
                            NavigationLink(destination: AjoutRemarqueView()){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                                    Text("Ajouter une remarque").foregroundColor(Color.black).padding(5)
                                }
                            }
                        }else{
                            Button(action: {
                                self.showingAlert = true
                            }){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                                    Text("Ajouter une remarque").foregroundColor(Color.black).padding(5)
                                }.padding(.bottom, 20)
                            }.alert(isPresented: $showingAlert){
                                Alert(title: Text("Vous n'êtes pas connecté !"),
                                      message: Text("La connexion est obligatoire pour ajouter une remarque"),
                                      dismissButton: .default(Text("J'ai compris")))
                                    
                            }
                        }
                            

                    }
                    
                }.navigationBarTitle("Accueil", displayMode: .inline)
                    .navigationBarItems(leading:
                        HStack{
                            if(!estConnecte){
                                NavigationLink(destination: InscriptionView(estConnecte: $estConnecte)){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Inscription").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }else{
                                NavigationLink(destination: AccueilView()){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 120, height:30)
                                        Text("Déconnexion").foregroundColor(Color.black).padding(5)
                                    }
                                }.simultaneousGesture(TapGesture().onEnded({
                                    //enelever personne du core data
                                    let person =  self.myPersonne[0]
                                    self.managedObjectContext.delete(person)
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        fatalError()
                                    }
                                    self.estConnecte = false
                                }))
                            }
                        }, trailing :
                        HStack{
                            if(!estConnecte){
                                NavigationLink(destination: ConnexionView(estConnecte : $estConnecte)){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Connexion").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }else{
                                NavigationLink(destination: ProfilView(estConnecte: $estConnecte)){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Profil").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }

                        }
                )
            }.background(Color("Turquoise"))
         .navigationViewStyle(StackNavigationViewStyle()) //+ jolie en mode tablette
        }
    }
}


struct AccueilView_Previews: PreviewProvider {
    static var previews: some View {
        AccueilView()
    }
}

