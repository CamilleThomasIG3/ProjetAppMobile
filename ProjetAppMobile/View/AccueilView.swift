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
    }
    
    var body: some View {
        NavigationView {
            Text("body")
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


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
