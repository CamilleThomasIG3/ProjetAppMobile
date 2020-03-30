//
//  ProfilView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/1/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    @Environment(\.presentationMode) var presentation
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
            entity: PersonneApp.entity(),
            sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    @Binding var estConnecte : Bool
    @ObservedObject var personneDAO = PersonneDAO()
    
    var body: some View {
        VStack(alignment: .leading, spacing : 20){
            HStack{
                Spacer()
                VStack(spacing : 20){
                    Text("Mon profil").font(.largeTitle)
                    
                    Image("profile")
                    
                    Text("Pseudo").font(.headline)
                    if(self.myPersonne.array.count != 0){
                        Text(self.myPersonne[0].pseudo!).font(.subheadline)
                    }

                    Text("Email").font(.headline)
                    if(self.myPersonne.array.count != 0){
                        Text(self.myPersonne[0].email!).font(.subheadline)
                    }
                    
                    NavigationLink(destination: ModifierProfilView()){
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color("Turquoise")).frame(width: 200, height:40)
                            Text("Modifier le pseudo").foregroundColor(Color.black).padding(5)
                        }
                    }
                    Button(action: {
                        self.deleteAccount(id : self.myPersonne[0].id!)
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Supprimer le compte").underline().foregroundColor(Color("Turquoise")).padding(.leading, 10)
                    }

                }.onAppear{
                    
                }
                
                Spacer()
            }
            Spacer()
        }.padding()
    }
    
    func deleteAccount(id : String){
        self.estConnecte = false
        
        self.managedObjectContext.delete(myPersonne[0])

        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError()
        }
        
        personneDAO.deletePersonne(id: id)
    }
}
