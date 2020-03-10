//
//  AddReponseView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct AjoutReponseView: View {
    @Environment(\.presentationMode) var presentation
    @State private var reponse: String=""
    var cats = ["Humour", "Loi", "Citation"]
    @State private var selectedCat = 0
    @ObservedObject var reponseDAO = ReponseDAO()
    var remarque : Remarque
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 40){
                Spacer()
                Text("Vous répondez à cette remarque : ")
                Text("gkljgiojgeijgoeoijgerijgergjerojgeijgjggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg").padding(20)
                
                Form{
                    Section{
                        
                        VStack(alignment: .leading){
                            Picker(selection: $selectedCat, label: Text("Catégorie")) {
                                ForEach(0 ..< cats.count){
                                    Text(self.cats[$0])
                                }
                            }
                            Spacer(minLength: 20)
                            Text("Votre réponse :")
                            TextField("réponse", text: $reponse).textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }.padding(50)
                    }
                    Section(){
                        Button(action: {
                            self.addReponse(idRemarque: self.remarque._id)
                            self.presentation.wrappedValue.dismiss()
                        }){
                            Text("Valider")
                        }
                    }
                        
                }.navigationBarTitle("Ajouter une réponse")
            }
        }
    }
    
    func addReponse(idRemarque : String){
        let rem = ReponseWithoutId(date: Date.init().description, contenu: "test ajout réponse", idPersonne: "tesstg5f5", idCategorieReponse: "1")
        reponseDAO.addReponse(r: rem, idRemarque: idRemarque)
    }
}


//struct AjoutReponseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AjoutReponseView()
//    }
//}
