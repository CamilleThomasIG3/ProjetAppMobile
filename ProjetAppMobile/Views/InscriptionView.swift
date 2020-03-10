//
//  InscriptionView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/26/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import Combine

struct InscriptionView: View {
    @Environment(\.presentationMode) var presentation
    @State private var pseudo: String=""
    @State private var email: String=""
    @State private var confEmail: String=""
    @State private var mdp: String=""
    @State private var confMdp: String=""

    @Binding var estConnecte : Bool
    @State private var showingAlert = false
    
    @ObservedObject var personneDAO = PersonneDAO()
    
    var body: some View {
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
                        SecureField("Mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Confirmation du mot de passe")
                        SecureField("Confirmez votre mot de passe",text: $confMdp).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding(50)
                }
                Section(){
                    Button(action: {
                        if(self.inscription()){
                           self.presentation.wrappedValue.dismiss()
                        }
                        else{
                            
                        }
                    }){
                        Text("Valider")
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text("Les données ne sont pas conformes !"),
                              message: Text("Vérifiez vos données"),
                              dismissButton: .default(Text("J'ai compris")))
                    }
                }
                                     
            }.navigationBarTitle("Créer un compte")
    }
    
  func inscription() -> Bool{
        let user = UserWithoutId(email: self.email, pseudo: self.pseudo, password: self.mdp)
        var resInscription = false
    
        personneDAO.addUser(user: user, completionHandler: {
            res in
            if(res){
                self.estConnecte.toggle()
                resInscription = true
            }else{
                print("oops")
                //AFFICHER MESSAGE ERREUR !
            }
        })
        return resInscription
    }

}

//struct InscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        InscriptionView(estConnecte: $estConnecte)
//    }
//}
