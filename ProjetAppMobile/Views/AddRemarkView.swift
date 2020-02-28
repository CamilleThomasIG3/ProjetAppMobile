//
//  AddRemarkView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct AddRemarkView: View {
    @Environment(\.presentationMode) var presentation
    @State private var remarque: String=""
    var body: some View {
        NavigationView{
            Form{
                Section{
                    VStack(){
                        Text("Votre remarque :")
                        //MultilineTextView(text: $remarque)
                        TextField("Remarque", text: $remarque).textFieldStyle(RoundedBorderTextFieldStyle())
                        
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


struct AddRemarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddRemarkView()
    }
}
  
