//
//  ContentView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/23/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation
struct ContentView: View {
    
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(named: "Turquoise")
        UINavigationBar.appearance().titleTextAttributes =
            [.foregroundColor: UIColor.white, .font: UIFont(name: "helvetica", size: 30)!]
 
//        Webservice().getAllPosts(){
//            print($0)
//        }
    }
    
    @ObservedObject var model = Webservice()
    
    var body: some View {
        
        NavigationView {
            List(model.posts){ post in
                Text(post.title)
            }
                .navigationBarTitle("Accueil", displayMode: .inline)
                .navigationBarItems(leading:
                    HStack{
                        Button(action:{}){
                            Image("sign_in")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                        }.foregroundColor(.red)
                        .padding(20)
                    }, trailing:
                    HStack{
                        Button(action: {}){
                            Image("profile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }.foregroundColor(.red)
                        .padding(10)
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

