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
    
    @ObservedObject var personneDAO = PersonneDAO()
    @ObservedObject var reponseDAO = ReponseDAO(idRemarque: "5e5fad3ddbc6392fd08438b7") //attention à enlever
    var body: some View {
            Form{
                Section{
                   
                    VStack(alignment: .leading){
                        Text("Email")
                        TextField("Email",text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Mot de passe")
                        TextField("Mot de passe",text: $mdp).textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {// attention à enlever
                            self.testReponses()
                            self.presentation.wrappedValue.dismiss()
                        }){
                            Text("Valider")
                        }

                        NavigationLink(destination: InscriptionView()){
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
    
    func testReponses() {// a enlever
        reponseDAO.getAnswers()
    }
}

struct ConnexionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionView()
    }
}
