//
//  ListeReponses.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation
import Combine

struct ListeReponses: View {
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    var cats = ["Récent", "J'aime", "Catégories", "Les miennes"]
    @State private var selectedCat = 0
    
    @State var pseudo : String = ""
    @ObservedObject var reponseDAO = ReponseDAO()
    var remarque : Remarque
    
    @Binding var estConnecte : Bool
    
    @State var showingCategories = false
    @State var activeBoxes : [String:Bool]  = ["Général":false, "Humour":false, "Loi":false, "Citation":false]
    
    
    var body: some View {
        VStack{
            //Barre de la liste
            VStack{
                ZStack {
                    Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40)
                    Text("Réponses").multilineTextAlignment(.leading)
                }
                
                if(estConnecte){
                    Picker(selection: $selectedCat, label: Text("Catégorie")) {
                        ForEach(0 ..< cats.count){
                            Text(self.cats[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .onReceive(Just(self.selectedCat)) {
                            value in
                            if(value == 2){
                                self.showingCategories=true
                            }else{
                                self.showingCategories=false
                            }
                    }
                }
                else{
                    Picker(selection: $selectedCat, label: Text("Catégorie")) {
                        ForEach(0 ..< cats.count-1){
                            Text(self.cats[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .onReceive(Just(self.selectedCat)) {
                            value in
                            if(value == 2){
                                self.showingCategories=true
                            }else{
                                self.showingCategories=false
                            }
                    }
                }
                if(showingCategories){
                    HStack{
                        RadioButton(text: "Général", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Général"))
                        RadioButton(text: "Humour", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Humour"))
                        RadioButton(text: "Loi", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Loi"))
                        RadioButton(text: "Citation", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Citation"))
                    }
                }
            }.padding(20)
                .onAppear{
                    if(self.estConnecte){
                        self.pseudo = self.myPersonne[0].pseudo!
                    }
            }
            
            //  Liste réponses
            List {
                ForEach(self.tri()){ answer in
                    ReponseDetail(answer : answer, remarque: self.remarque, estConnecte: self.$estConnecte)
                }
            }.onAppear{
                //enlever separators de la liste
                UITableView.appearance().separatorStyle = .none
                self.reponseDAO.getAnswers(idRemarque: self.remarque._id)
            }
        }
    }
    
    func getColorCategoryReponse(cat : String)-> Color{
        var color : Color = Color.black
        
        if(cat=="Général"){
            color = Color.green
        }
        if(cat=="Humour"){
            color = Color.orange
        }
        if(cat=="Loi"){
            color = Color.red
        }
        if(cat=="Citation"){
            color = Color.blue
        }
        return color
    }
    
    func tri() -> [Reponse]{
        if(cats[selectedCat] == "J'aime"){
            //tri par ordre décroissant des remarques en fonction du nombre de fois qu'elle a été entendue
            return self.reponseDAO.answers.sorted{$0.likes.count > $1.likes.count}
        }
        else if(cats[selectedCat] == "Catégories"){
            var find = false
            for i in self.activeBoxes.keys {
                if(!find && self.activeBoxes[i]!){
                    find = true
                    return reponseDAO.answers.filter{$0.categoryResponse == i}
                }
            }
            if(!find){
                return reponseDAO.answers
            }
        }
        else if(cats[selectedCat] == "Les miennes"){
            return reponseDAO.answers.filter{$0.user == pseudo}
        }
        else{
            return self.reponseDAO.answers
        }
    }
}
