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
    @State var reponse: String=""
    var cats = ["Général","Humour", "Loi", "Citation"]
    @State var selectedCat = 0
    
    @State var textHeight: CGFloat = 80
    @ObservedObject var reponseDAO = ReponseDAO()
    var remarque : Remarque
    
    
    var body: some View {
        KeyboardHost{
            VStack(alignment: .center, spacing: 40){
                Spacer()
                Text("Vous répondez à cette remarque : ")
                VStack{
                    Text(remarque.title).font(.headline)
                    Text(remarque.content).padding(.trailing, 10).padding(.leading,10).multilineTextAlignment(.center)
                }.border(Color.gray).padding(.trailing,20).padding(.leading,20)
                
                Form {
                    Section{
                        
                        VStack(alignment: .leading){
                            Picker(selection: $selectedCat, label: Text("Catégorie")) {
                                ForEach(0 ..< cats.count){
                                    Text(self.cats[$0])
                                }
                            }
                            
                            Spacer(minLength: 20)
                            Text("Votre réponse :")
                            VStack {
                                TextView(placeholder: "Votre réponse", text: self.$reponse, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                            }
                            
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
        let rem = ReponseWithoutId(date: Date.init().description, contenu: self.reponse, idPersonne: "tesstg5f5", idCategorieReponse: cats[selectedCat])
        reponseDAO.addReponse(r: rem, idRemarque: idRemarque)
        
    }
}


//struct AjoutReponseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AjoutReponseView()
//    }
//}
