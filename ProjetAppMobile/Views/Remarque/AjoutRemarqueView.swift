//
//  AddRemarkView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct AjoutRemarqueView: View {
    @Environment(\.presentationMode) var presentation
    
    @State var textHeight: CGFloat = 80
    
    var cats = ["Général", "Rue", "Travail", "Transports", "Famille"]
    @State private var selectedCat = 0
    
    @State private var content: String=""
    @State private var title: String=""
    @ObservedObject var remarqueDAO = RemarqueDAO()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    var body: some View {

            Form{
                Section{
                    VStack(){
                        Picker(selection: $selectedCat, label: Text("Catégorie")) {
                            ForEach(0 ..< cats.count){
                                Text(self.cats[$0])
                            }
                        }
                        Spacer(minLength: 20)
                        
                        Text("Titre :")
                        TextField("Titre",text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Remarque sexiste :")
                        VStack {
                            TextView(placeholder: "Votre remarque", text: self.$content, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                                .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                        }
                    }.padding(50)
                      
                }
                Section(){
                    Button(action: {
                        self.addRemarque()
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Valider")
                    }
                }
                
            }.navigationBarTitle("Ajouter une remarque")
   
    }
    
    func addRemarque() {
        let remarque = RemarqueWithoutId(title: title, date: Date.init().description, content: content, user: myPersonne[0].pseudo!, idCategory: cats[selectedCat])
        
        remarqueDAO.addRemarque(remarque: remarque, completionHandler: {
            res in
            if (!res){
                print("erreur lors de ajout remarque")
            }
        })
    }
    
}
  
