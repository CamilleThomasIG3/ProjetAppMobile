//
//  ConnexionView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/26/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import BCrypt

struct ConnexionView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var email: String=""
    @State private var mdp: String=""
    @State private var showingAlert = false
    
    @Binding var estConnecte : Bool
    
    @ObservedObject var personneDAO = PersonneDAO()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
            entity: PersonneApp.entity(),
            sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    

    var person = PersonneApp()
    
//    init() {
//        person = PersonneApp(context: self.managedObjectContext)
//    }
    
    var body: some View {
            Form{
                Section{
                   
                    VStack(alignment: .leading){
                        Text("Email")
                        TextField("Email",text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Mot de passe")
                        TextField("Mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        NavigationLink(destination: InscriptionView(estConnecte: $estConnecte)){
                            Text("S'incrire").underline()
                            .foregroundColor(Color("Turquoise"))
                        }.buttonStyle(PlainButtonStyle())
                    }.padding(50)
                }
                Section(){
                    Button(action: {
                        self.login()
                    }){
                        Text("Valider")
                    }
                }
                                   
            }.navigationBarTitle("Connexion")
    }
    
    func login(){
        personneDAO.authentification(email: self.email, password: self.mdp, completionHandler: {
            res in
            if(res){
                self.estConnecte = true
                
                //CoreData
                self.person.email = self.email
                self.person.mdp = self.mdp
                // more code here
                do {
                    try self.managedObjectContext.save()
                } catch {
                    fatalError()
                }
                
                self.presentation.wrappedValue.dismiss()
            }
            else{
                self.showingAlert = true
            }
        })
    }
    
    func getId() {
        personneDAO.getPersonneByEmail(email: self.email, completionHandler: {
            res in
            if(res.count != 0){
                self.person.id = res[0]._id
            }
        })
    }
}

//struct ConnexionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnexionView()
//    }
//}
