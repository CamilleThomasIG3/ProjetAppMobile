//
//  InscriptionView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/26/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

struct InscriptionView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var pseudo: String=""
    @State private var email: String=""
    @State private var confEmail: String=""
    @State private var mdp: String=""
    @State private var confMdp: String=""

    @Binding var estConnecte : Bool
    @State private var showingAlert = false
    
    @ObservedObject var personneDAO = PersonneDAO()
    
    
    @FetchRequest(
            entity: PersonneApp.entity(),
            sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    
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
                        TextField("Mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Confirmation du mot de passe")
                        TextField("Confirmez votre mot de passe",text: $confMdp).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding(50)
                }
                Section(){
                    Button(action: {
                        self.inscription()
                        print(self.myPersonne[0].email)
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
    
  func inscription(){
        let user = UserWithoutId(email: self.email, pseudo: self.pseudo, password: self.mdp)
    
        personneDAO.addUser(user: user, completionHandler: {
            res in
            if(res){
                self.estConnecte.toggle()
                
                //CoreData
                let person = PersonneApp(context: self.managedObjectContext)
                person.email = self.email
                person.mdp = self.mdp
                // more code here
                do {
                    try self.managedObjectContext.save()
                } catch {
                    fatalError()
                }
                
                self.presentation.wrappedValue.dismiss()
            }else{
                self.showingAlert = true
            }
        })
    }

}

//struct InscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        InscriptionView(estConnecte: $estConnecte)
//    }
//}
