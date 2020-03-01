//
//  ModifierProfilView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/1/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct ModifierProfilView: View {
    @Environment(\.presentationMode) var presentation
    @State private var pseudo: String="Cams"
    @State private var mdp: String=""

    var body: some View {
        NavigationView{
            Form{
                Section{
                    VStack(alignment: .leading){
                        Text("Pseudo").font(.headline)
                        TextField("Pseudo", text: $pseudo).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Mot de passe")
                        TextField("Mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding(50)
                }
                Section(){
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Valider")
                    }
                }
            }.navigationBarTitle("Modifier pseudo")
        }
    }
}

struct ModifierProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ModifierProfilView()
    }
}
