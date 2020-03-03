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
    
    @ObservedObject var remarqueDAO = RemarqueDAO()

    var body: some View {
       // NavigationView{
            VStack(alignment: .leading, spacing : 20){
                Text("Mon profil").font(.largeTitle)
                
                Text(remarqueDAO.getRemarque(id : "5e5e8d26d508643fb434c862")!.getContenu())
                
                Image("profile")
                
                Text("Pseudo").font(.headline)
                Text("Cams").font(.subheadline)
                Text("Email").font(.headline)
                Text("test@test.fr").font(.subheadline)
                        
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
            }.padding()//.offset(y: -200)
        //}.navigationBarTitle("Profil")
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
