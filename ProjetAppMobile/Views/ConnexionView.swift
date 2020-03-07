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
    
    @Binding var estConnecte : Bool
    
    @ObservedObject var personneDAO = PersonneDAO()
    
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
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Valider")
                    }
                }
                                   
            }.navigationBarTitle("Connexion")
    }
    
    func login(){
        personneDAO.getPersonneById(id: "5e5e732fc3f7040ebc491de2", completionHandler : {
            user in
            if(user.count == 0){
                print("No User")
            }
            else{
                print("user trouvé!!")
                self.estConnecte = true
//                let result = try! BCrypt.Hash.verify(message: self.password , matches: user[0].password )
//                print(result)
//                if(result){
//                  print("connecté")
//                }
//                else{
//                    print("pas connecté)")
//                }
            }
        })
    }
}

//struct ConnexionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnexionView()
//    }
//}
