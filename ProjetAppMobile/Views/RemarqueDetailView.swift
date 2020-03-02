//
//  RemarqueDetailView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/2/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit

struct RemarqueDetailView: View {
    var cats = ["Dans la rue", "Au travail", "Dans les transports"]
    @State private var selectedCat = 0
    var body: some View {
        VStack {
            Text("Remarque").font(.largeTitle)
            ZStack {
                Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40).padding(10)
                HStack {
                    Text("Pseudo").multilineTextAlignment(.leading)
                    Text("21/02/20").multilineTextAlignment(.trailing)
                }
            }
                Text("remarque longue")
            Divider()
            ZStack {
                Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40).padding(10)
                HStack {
                    Text("Réponses").multilineTextAlignment(.leading)
//                    Picker(selection: $selectedCat, label: Text("Catégorie")) {
//                        ForEach(0 ..< cats.count){
//                            Text(self.cats[$0])
//                        }
//                    }
                }
            }
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
}

struct RemarqueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RemarqueDetailView()
    }
}
