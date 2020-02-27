//
//  InscriptionView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/26/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct InscriptionView: View {
    @Environment(\.presentationMode) var presentation
    @State private var pseudo: String=""
    @State private var email: String=""
    @State private var confEmail: String=""
    @State private var mdp: String=""
    @State private var confMdp: String=""

    var body: some View {
        NavigationView{
            Form{
                Section{
                   
                    VStack(alignment: .leading){
                        Text("Pseudo").font(.headline)
                        TextField("Pseudo", text: $pseudo).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Email")
                        TextField("Email",text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Confirmation d'email")
                        TextField("Confirmation d'email",text: $confEmail).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Mot de passe")
                        TextField("Mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Confirmation du mot de passe")
                        TextField("Confirmez votre mot de passe",text: $confMdp).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding(50)
                }
                Section(){
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Valider")
                    }
                }
                                     
            }.navigationBarTitle("Créer un compte")
        }
    }
}

struct InscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        InscriptionView()
    }
}
