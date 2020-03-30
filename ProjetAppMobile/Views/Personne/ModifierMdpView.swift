//
//  ModifierMdpView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/30/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct ModifierMdpView: View {
    @Environment(\.presentationMode) var presentation
    @State private var ancienMdp: String = ""
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
            Text("Modifier mot de passe").font(.largeTitle)
            Form{
                Section{
                    VStack(alignment: .leading){
                        Text("Ancien mot de passe").font(.headline)
                        SecureField("Ancien mot de passe", text: $ancienMdp).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Nouveau mot de passe")
                        SecureField("Nouveau mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding(50)
                }
                Section(){
                    Button(action: {
                        self.editMdp()
                    }){
                        Text("Valider")
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text("Les données ne sont pas conformes !"),
                              message: Text("Vérifiez vos données"),
                              dismissButton: .default(Text("J'ai compris")))
                    }
                }
            }
        }
    }
    
    func editMdp(){
        personneDAO.editMdp(id: self.myPersonne[0].id!, ancienMdp: self.ancienMdp, mdp : self.mdp, completionHandler: {
            res in
            if(res){
                self.presentation.wrappedValue.dismiss()
            }else{
                self.showingAlert = true
            }
        })
    }
}

struct ModifierMdpView_Previews: PreviewProvider {
    static var previews: some View {
        ModifierMdpView()
    }
}
