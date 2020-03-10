//
//  RemarqueDetailView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/2/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct RemarqueDetailView: View {
    var cats = ["Date", "Fréquence", "Catégorie"]
    @State private var selectedCat = 0
    @ObservedObject var reponseDAO = ReponseDAO()
    var remarque : Remarque
    
    init(remarque: Remarque){
        self.remarque = remarque
        reponseDAO.getAnswers(idRemarque: remarque._id)
    }
    
    var body: some View {
        VStack {
            //Remarque détaillée
            VStack{
                Text("Remarque").font(.largeTitle)
                ZStack {
                    Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40).padding(10)
                    HStack {
                        Text(remarque.user).padding(20)
                        Spacer()
                        Text(remarque.idCategory).padding(20).foregroundColor(.green)
                        Spacer()
                        Text(self.convertDate(date : remarque.date)).padding(20)
                    }
                }
                Text(remarque.content)
            }
            Divider()
            VStack{
                //Barre Réponses
                ZStack {
                    Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40).padding(10)
                    Text("Réponses").multilineTextAlignment(.leading)
                }

                Picker(selection: $selectedCat, label: Text("Tri")) {
                    ForEach(0 ..< cats.count){
                        Text(self.cats[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
          //  Liste réponses
            
            List {
                ForEach(reponseDAO.answers){ answer in
                    VStack {
                        HStack {
                            Text(answer.user)
                            Text(self.convertDate(date : answer.date))
                            Text(answer.categoryResponse).foregroundColor(.orange)
                        }
                        HStack {
                            Text(answer.content)
                        }
                    }
                    VStack{
                        HStack {
                            Button(action: {
                                
                                
                            })
                            {
                                Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                            Text("\(answer.likes.count)")
                            Button(action: { print("ok") }){
                                Image("warning").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                        }
                    }
                }
            }
        
            NavigationLink(destination: AjoutReponseView(remarque : remarque)){
                Text("Ajouter une réponse")
            }.buttonStyle(PlainButtonStyle()).padding(10)
        }
            
    }
        

    
   
    
    func convertDate(date : String) -> String{
        //String to date
        let formatter4 = DateFormatter()
        formatter4.locale = Locale(identifier: "en_US_POSIX")
        formatter4.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date2 : Date? = formatter4.date(from: date)
        
        //Date to string
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date2!)
    }
}

//struct RemarqueDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemarqueDetailView()
//    }
//}
