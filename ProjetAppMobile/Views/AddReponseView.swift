//
//  AddReponseView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct AddReponseView: View {
    @Environment(\.presentationMode) var presentation
    @State private var reponse: String=""
    var cats = ["Humour", "Loi", "Citation"]
    @State private var selectedCat = 0
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 40){
                Spacer()
                Text("Vous répondez à cette remarque : ")
                Text("gkljgiojgeijgoeoijgerijgergjerojgeijgjggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg").padding(20)
                
                Form{
                    Section{
                        
                        VStack(alignment: .leading){
                            Picker(selection: $selectedCat, label: Text("Catégorie de réponse")) {
                                ForEach(0 ..< cats.count){
                                    Text(self.cats[$0])
                                }
                            }
                            Spacer()
                            Text("Votre réponse :")
                            TextField("réponse", text: $reponse).textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }.padding(50)
                    }
                    Section(){
                        Button(action: {
                            self.presentation.wrappedValue.dismiss()
                        }){
                            Text("Valider")
                        }
                    }
                        
                }.navigationBarTitle("Ajouter une réponse")
            }
        }
    }
}


struct AddReponseView_Previews: PreviewProvider {
    static var previews: some View {
        AddReponseView()
    }
}
