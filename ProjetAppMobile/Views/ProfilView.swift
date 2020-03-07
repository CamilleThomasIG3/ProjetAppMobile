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
    
    @State private var pseudo: String=""
    @State private var email: String=""
    @State private var confEmail: String=""
    @State private var mdp: String=""
    @State private var confMdp: String=""
    
    @ObservedObject var personneDAO = PersonneDAO()

    init() {
        personneDAO.getPersonneById(id: "5e6391078e878e00175a2cb2", completionHandler: {
            user in
            if(user.count == 0){
                print("No User")
            }
            else{
                print("user trouvé!!")
            }
        })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing : 20){
            HStack{
                Spacer()
                VStack(spacing : 20){
                    Text("Mon profil").font(.largeTitle)
                    
                    Image("profile")
                    
                    Text("Pseudo").font(.headline)
                    Text(personneDAO.personnes[0].pseudo).font(.subheadline)

                    Text("Email").font(.headline)
                    Text(personneDAO.personnes[0].email).font(.subheadline)
                    
                    NavigationLink(destination: ModifierProfilView(person : personneDAO.personnes[0])){
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color("Turquoise")).frame(width: 200, height:40)
                            Text("Modifier le pseudo").foregroundColor(Color.black).padding(5)
                        }
                    }
                    Button(action: {
                        self.deleteAccount(id : self.personneDAO.personnes[0]._id)
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Supprimer le compte").underline().foregroundColor(Color("Turquoise")).padding(.leading, 10)
                    }

                }
                Spacer()
            }
            Spacer()
        }.padding()
    }
    
    func deleteAccount(id : String){
        personneDAO.deletePersonne(id: id)
        print("delete after")
    }
}




struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
