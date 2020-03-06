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
    @State private var remarque: String=""
    @State var textHeight: CGFloat = 80
    var cats = ["Dans la rue", "Au travail", "Dans les transports"]
    @State private var selectedCat = 0
    
    
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
                        Text("Remarque sexiste :")
//                        UITextView()
                        
                        //TextField("Remarque", text: $remarque).textFieldStyle(RoundedBorderTextFieldStyle())
                        VStack {
                        //ScrollView {
                            Text("Zone de saisie mieux que TextField:").bold()
                            TextView(placeholder: "tapez un truc un peu long pour voir", text: self.$remarque, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                            .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                            Spacer()
                            Text("Contenu de la variable récupérant le texte tapé par l'utilisateur dans le 'TextView' du haut :").bold().padding().foregroundColor(.blue)
                            Text(remarque).foregroundColor(.red)
                        }
                    }.padding(50)
                      
                }
                Section(){
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Text("Valider")
                    }
                }
                
            }.navigationBarTitle("Ajouter une remarque")
   
    }
}

//struct MultilineTextView: UIViewRepresentable {
//
//    @Binding var text: String
//    func makeUIView(context: Context) -> UITextView {
//        let view = UITextView()
//        view.isScrollEnabled = true
//        view.isEditable = true
//        view.isUserInteractionEnabled = true
//        return view
//    }
//    func updateUIView(_ uiView: UITextView, context: Context){
//        uiView.text = text
//    }
//}


struct AjoutRemarqueView_Previews: PreviewProvider {
    static var previews: some View {
        AjoutRemarqueView()
    }
}
  
