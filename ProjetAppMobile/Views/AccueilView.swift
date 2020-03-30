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
import Combine

struct AccueilView: View {
    var cats = ["Récent", "Fréquence", "Catégories", "Les miennes"]
    @State private var selectedCat = 0
    
    @State var estConnecte  = false
    @State var showingAlert = false
    @State var showingCategories = false
    
    @State var activeBoxes : [String:Bool]  = ["Général":false, "Rue":false, "Travail":false, "Transports":false, "Famille":false]
    
    @ObservedObject var remarqueDAO = RemarqueDAO()
    
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named : "Turquoise")
    }
    
    var body: some View {
        VStack{
            NavigationView{
                VStack(spacing: 20){
                    VStack{
                        HStack{
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
                        }.padding(10)
                        
                        if(showingCategories){
                            HStack{
                                RadioButton(text: "Général", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryRemarque(cat: "Général"))
                                RadioButton(text: "Rue", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryRemarque(cat: "Rue"))
                                RadioButton(text: "Travail", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryRemarque(cat: "Travail"))
                                RadioButton(text: "Transports", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryRemarque(cat: "Transports"))
                                RadioButton(text: "Famille", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryRemarque(cat: "Famille"))
                            }
                        }
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("Remarques sexistes").padding(.leading, 10)
                            Spacer()
                            Text("Fréquences").padding(.trailing, 10)
                        }.background(Color(UIColor(named: "Gris_clair")!)).padding(10)
                    }
                    
                    
                    List{
                        ForEach(self.tri()){
                            remarque in
                            HStack(alignment: .firstTextBaseline){
                                NavigationLink(destination: RemarqueDetailView(remarque : remarque, estConnecte : self.$estConnecte)){
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(self.getColorCategoryRemarque(cat: remarque.idCategory)).frame(width: 20, height:20)
                                    VStack{
                                        Text(remarque.title).font(.headline).lineLimit(1)
                                        Text(remarque.content).lineLimit(2)
                                    }.padding(10)
//                                    
//                                    Spacer()
//                                    Text(String(remarque.nbLikes)).padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    .onAppear {
                        self.remarqueDAO.getAllRemaques()
                        
                        //etre sure que core data est reinitialisé
                        if(self.estConnecte==false){
                            for e in self.myPersonne {
                                self.managedObjectContext.delete(e)
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    fatalError()
                                }
                            }
                        }
                    }
                    
                    HStack{
                        if(estConnecte){
                            NavigationLink(destination: AjoutRemarqueView()){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                                    Text("Ajouter une remarque").foregroundColor(Color.black).padding(5)
                                }
                            }
                        }else{
                            Button(action: {
                                self.showingAlert = true
                            }){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                                    Text("Ajouter une remarque").foregroundColor(Color.black).padding(5)
                                }.padding(.bottom, 20)
                            }.alert(isPresented: $showingAlert){
                                Alert(title: Text("Vous n'êtes pas connecté !"),
                                      message: Text("La connexion est obligatoire pour ajouter une remarque"),
                                      dismissButton: .default(Text("J'ai compris")))
                            }
                        }
                        
                        
                    }
                    
                }.navigationBarTitle("Accueil", displayMode: .inline)
                    .navigationBarItems(leading:
                        HStack{
                            if(!estConnecte){
                                NavigationLink(destination: InscriptionView(estConnecte: $estConnecte)){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Inscription").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }else{
                                NavigationLink(destination: AccueilView()){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 120, height:30)
                                        Text("Déconnexion").foregroundColor(Color.black).padding(5)
                                    }
                                }.simultaneousGesture(TapGesture().onEnded({
                                    //enelever personnes du core data
                                    for e in self.myPersonne {
                                        self.managedObjectContext.delete(e)
                                        
                                        do {
                                            try self.managedObjectContext.save()
                                        } catch {
                                            fatalError()
                                        }
                                    }
                                    self.estConnecte = false
                                }))
                            }
                        }, trailing :
                        HStack{
                            if(!estConnecte){
                                NavigationLink(destination: ConnexionView(estConnecte : $estConnecte)){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Connexion").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }else{
                                NavigationLink(destination: ProfilView(estConnecte: $estConnecte)){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 100, height:30)
                                        Text("Profil").foregroundColor(Color.black).padding(5)
                                    }
                                }
                            }
                            
                        }
                )
            }.background(Color("Turquoise"))
                .navigationViewStyle(StackNavigationViewStyle()) //étendu en mode tablette
        }
    }
    
    
    func tri() -> [Remarque]{
        if(cats[selectedCat] == "Fréquence"){
            //tri par ordre décroissant des remarques en fonction du nombre de fois qu'elle a été entendue
            return self.remarqueDAO.remarques.sorted{$0.nbLikes > $1.nbLikes}
        }
        else if(cats[selectedCat] == "Catégories"){
            var find = false
            for i in self.activeBoxes.keys {
                if(!find && self.activeBoxes[i]!){
                    find = true
                    return remarqueDAO.remarques.filter{$0.idCategory == i}
                }
            }
            if(!find){
                return remarqueDAO.remarques
            }
        }
        else if(cats[selectedCat] == "Les miennes"){
            return remarqueDAO.remarques.filter{$0.user == myPersonne[0].pseudo!}
        }
        else{
            return self.remarqueDAO.remarques
        }
    }
    
    func getColorCategoryRemarque(cat : String)-> Color{
        var color : Color = Color.black
        
        if(cat=="Général"){
            color = Color.green
        }
        if(cat=="Rue"){
            color = Color.orange
        }
        if(cat=="Travail"){
            color = Color.red
        }
        if(cat=="Transports"){
            color = Color.blue
        }
        if(cat=="Famille"){
            color = Color.purple
        }
        return color
    }
}


struct AccueilView_Previews: PreviewProvider {
    static var previews: some View {
        AccueilView()
    }
}

