//
//  RemarqueDetailView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/2/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation
import Combine

struct RemarqueDetailView: View {
    @Environment(\.presentationMode) var presentation
    
    var remarque : Remarque
    
    @Binding var estConnecte : Bool
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            RemarqueCard(remarque : self.remarque, estConnecte: self.$estConnecte)
            
            ListeReponses(remarque : self.remarque, estConnecte: self.$estConnecte)
            
            if(estConnecte){
                NavigationLink(destination: AjoutReponseView(remarque : remarque)){
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                        Text("Ajouter une réponse").foregroundColor(Color.black).padding(5)
                    }
                }
            }else{
                Button(action: {
                    self.showingAlert = true
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                        Text("Ajouter une réponse").foregroundColor(Color.black).padding(5)
                    }.padding(.bottom, 20)
                }.alert(isPresented: $showingAlert){
                    Alert(title: Text("Vous n'êtes pas connecté !"),
                          message: Text("La connexion est obligatoire pour ajouter une réponse"),
                          dismissButton: .default(Text("J'ai compris")))
                }
            }
        }
    }
}
