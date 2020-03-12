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
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text("Les données ne sont pas conformes !"),
                              message: Text("Vérifiez vos données"),
                              dismissButton: .default(Text("J'ai compris")))
                    }
                }
                                   
            }.navigationBarTitle("Connexion")
    }
    
    func login(){
        print(self.email)
        print(self.mdp)
        personneDAO.authentification(email: self.email, password: self.mdp, completionHandler: {
            res in
            if(res){
                self.estConnecte = true
                
                //CoreData
                let person = PersonneApp(context: self.managedObjectContext)
                person.email = self.email
                person.mdp = self.mdp
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    fatalError()
                }

                self.getId()
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
                self.myPersonne[0].id = res[0]._id
                self.myPersonne[0].pseudo = res[0].pseudo
                
                do{
                    try self.managedObjectContext.save()
                } catch {
                    fatalError()
                }
            }
        })
    }
}

//struct ConnexionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnexionView()
//    }
//}
