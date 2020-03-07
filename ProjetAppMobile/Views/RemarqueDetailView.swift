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
    
    var remarque : Remarque
    
    var body: some View {
        VStack {
            //Remarque détaillée
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
            
            Divider()
            
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
            
            
            //Liste réponses
            List {
                VStack {
                    HStack {
                        Text("Pseudo")
                        Text("Date")
                        Text("Catégorie").foregroundColor(.orange)
                    }
                    HStack {
                        Text("reponse1")
                    }
                    HStack {
                        Button(action: {
                            print("ok")})
                            {
                                Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                        Text("5")
                        Button(action: {
                        print("ok")})
                        {
                            Image("warning").resizable().frame(width: 30, height: 30, alignment : .trailing)
                        }

                    }
                }
                
                Text("reponse2")
                Text("reponse3")
                Text("reponse4")
            }
            NavigationLink(destination: AjoutReponseView()){
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
