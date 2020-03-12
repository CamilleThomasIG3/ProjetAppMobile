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
    @State private var pseudo: String = ""
    @State private var mdp: String = ""
    @State private var showingAlert = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
            entity: PersonneApp.entity(),
            sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    @ObservedObject var personneDAO = PersonneDAO()

    var body: some View {
        VStack {
            Text("Modifier pseudo").font(.largeTitle)
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
                        self.editPseudo()
                    }){
                        Text("Valider")
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text("Les données ne sont pas conformes !"),
                              message: Text("Vérifiez vos données"),
                              dismissButton: .default(Text("J'ai compris")))
                    }
                }
            }.onAppear{
                self.pseudo = self.myPersonne[0].pseudo!
            }
        }
    }
    
    func editPseudo(){
        personneDAO.editPseudo(id: self.myPersonne[0].id!, pseudo: self.pseudo, mdp : self.mdp, completionHandler: {
            res in
            if(res){
                self.myPersonne[0].pseudo = self.pseudo
                self.presentation.wrappedValue.dismiss()
            }else{
                self.showingAlert = true
            }
        })
    }
}

//struct ModifierProfilView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifierProfilView()
//    }
//}
