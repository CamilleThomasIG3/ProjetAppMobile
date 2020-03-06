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
    @ObservedObject var reponseDAO = ReponseDAO(idRemarque: "5e5fad3ddbc6392fd08438b7") //attention à enlever
    var body: some View {
        VStack(alignment: .leading, spacing : 20){
            Text("Mon profil").font(.largeTitle)
            
            Image("profile")
            
            Text("Pseudo").font(.headline)
            Text("Cams").font(.subheadline)
            
            Text("Email").font(.headline)
            Text("test@test.fr").font(.subheadline)
            HStack {
                Button(action: {// attention à enlever
                    self.testReponses()
                    self.presentation.wrappedValue.dismiss()
                }){
                    Text("testReponses")
                }
                Button(action: {// attention à enlever
                               self.testAddReponse()
                               self.presentation.wrappedValue.dismiss()
                           }){
                               Text("testReponses")
                }
            }
            
           
            NavigationLink(destination: ModifierProfilView()){
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(Color("Turquoise")).frame(width: 200, height:40)
                    Text("Modifier le pseudo").foregroundColor(Color.black).padding(5)
                }
            }
            
            NavigationLink(destination: AccueilView()){
                Text("Supprimer le compte").underline().foregroundColor(Color("Turquoise"))
            }.buttonStyle(PlainButtonStyle())
            
            Spacer()
        }.padding()
    }
    
    func testReponses() {// a enlever
        reponseDAO.getAnswers()
    }
    
    func testAddReponse() {
        let rep = ReponseWithoutId(date: "2020-03-04T13:29:33.693Z", contenu: "test ajout réponse", idPersonne: "5e627a599cb0c9247cad135a", idCategorieReponse: "fonctionnebien")
        reponseDAO.addReponse(r: rep)
    }
}




struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
