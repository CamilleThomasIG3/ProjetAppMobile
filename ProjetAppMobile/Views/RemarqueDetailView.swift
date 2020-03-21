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
import Combine

struct RemarqueDetailView: View {
    @Environment(\.presentationMode) var presentation
    
    var cats = ["Récent", "J'aime", "Catégories", "Les miennes"]
    @State private var selectedCat = 0
    
    @ObservedObject var reponseDAO = ReponseDAO()
    @ObservedObject var remarqueDAO = RemarqueDAO()
    var remarque : Remarque
    
    @Binding var estConnecte : Bool
    @State private var showingAlert = false
    @State private var showingAlertAime = false
    @State private var showingAlertSignal = false
    @State private var isHiddenEntendu = false
    
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    @State var showingCategories = false
    @State var activeBoxes : [String:Bool]  = ["Général":false, "Humour":false, "Loi":false, "Citation":false]
    
    init(remarque: Remarque, estConnecte : Binding<Bool>){
        self.remarque = remarque
        self._estConnecte = estConnecte
    }
    
    var body: some View {
        VStack {
            //Remarque détaillée
            VStack{
                Text(remarque.title).font(.largeTitle)
                Divider()
                ZStack {
                    Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40).padding(10)
                    HStack {
                        Text(remarque.user).padding(20)
                        Spacer()
                        Text(remarque.idCategory).padding(20)
                            .foregroundColor(self.getColorCategoryRemarque(cat: remarque.idCategory))
                        Spacer()
                        Text(self.convertDate(date : remarque.date)).padding(20)
                    }
                }
                Text(remarque.content).multilineTextAlignment(.center).padding(10)
                
                //Button déjà entendu et supprimer remarque
                HStack {
                    if (self.estConnecte) {
                        if (!self.alreadyHeard() && !self.isHiddenEntendu) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color.blue).frame(width: 130, height:30)
                                Text("Déjà entendu").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                    self.remarqueDAO.addFrequence(id: self.remarque._id, user: self.myPersonne[0].pseudo!, completionHandler: {
                                        res in
                                        if (!res) {
                                            print("erreur lors de l'ajout de fréquence")
                                        }
                                    })
                                    self.isHiddenEntendu = true
                                }
                            }
                        }
                        else if(self.alreadyHeard() || self.isHiddenEntendu){
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color.blue).opacity(0.5).frame(width: 130, height:30)
                                Text("Déjà entendu").foregroundColor(Color.white).bold().padding(5)
                            }
                        }
                        if(remarque.user == self.myPersonne[0].pseudo!){
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color.red).frame(width: 130, height:30)
                                Text("Supprimer").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                    self.remarqueDAO.deleteRemarque(id: self.remarque._id)
                                    self.presentation.wrappedValue.dismiss()                                    
                                }
                        }
                            
                        }
                    }
                }
            }
            
            VStack{
                //Barre Réponses
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
                        RadioButton(text: "Général", boxes : self.$activeBoxes)
                        RadioButton(text: "Humour", boxes : self.$activeBoxes)
                        RadioButton(text: "Loi", boxes : self.$activeBoxes)
                        RadioButton(text: "Citation", boxes : self.$activeBoxes)
                    }
                }
            }.padding(20)
            
          //  Liste réponses
            List {
                ForEach(self.tri()){ answer in
                    VStack {
                        HStack {
                            Text(answer.user)
                            Spacer()
                            Text(self.convertDate(date : answer.date))
                            Spacer()
                            Text(answer.categoryResponse)
                                .foregroundColor(self.getColorCategoryReponse(cat: answer.categoryResponse))
                        }.padding(10).border(Color("Gris_fonce")).background(Color("Gris_clair"))
                        
                        
                        VStack {
                            Text(answer.content).multilineTextAlignment(.center)
                        
                        HStack {
                            Button(action: { print("nok") }){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                    Image("warning").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                }
                            }.padding(.leading, 10)
                            
                            Spacer()
                            
                            //Boutton supprimer si la reponse de la personne connectée
                            if(answer.user == self.myPersonne[0].pseudo!){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.red).frame(width: 130, height:30)
                                    Text("Supprimer").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                        self.reponseDAO.deleteReponseById(idRep: answer._id, idRemarque: self.remarque._id)
                                        self.presentation.wrappedValue.dismiss()
                                    }
                                }
                            }
                                
                            Spacer()
                            
                            Text("\(answer.likes.count)").padding(.trailing, 10)
                            
                            if(self.estConnecte){
                                Button(action: {
                                    self.like(reponse : answer)
                                })
                                {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                        Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                    }
                                }
                            }else{
                                Button(action: {self.showingAlertAime=true})
                                {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                        Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                    }
                                }.alert(isPresented: self.$showingAlertAime){
                                    Alert(title: Text("Vous n'êtes pas connecté !"),
                                          message: Text("La connexion est obligatoire pour aimer une réponse"),
                                          dismissButton: .default(Text("J'ai compris")))
                                }
                            }
                        }.padding(10).buttonStyle(PlainButtonStyle())
                            }.padding(.top, 20)
                    }.border(Color("Gris_fonce"))
                }
            }.onAppear{
                //enlever separators de la liste
                UITableView.appearance().separatorStyle = .none
                self.reponseDAO.getAnswers(idRemarque: self.remarque._id)
            }
            
            if(estConnecte){
                NavigationLink(destination: AjoutReponseView(remarque : remarque)){
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                        Text("Ajouter une réponse").foregroundColor(Color.black).padding(5)
                    }
                }
            }else{
                Button(action: {
                    self.showingAlert = true
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color("Turquoise")).frame(width: 180, height:30)
                        Text("Ajouter une réponse").foregroundColor(Color.black).padding(5)
                    }.padding(.bottom, 20)
                }.alert(isPresented: $showingAlert){
                    Alert(title: Text("Vous n'êtes pas connecté !"),
                          message: Text("La connexion est obligatoire pour ajouter une réponse"),
                          dismissButton: .default(Text("J'ai compris")))
                        
                }
            }

        }
            
    }
        
    func getColorCategoryRemarque(cat : String)-> Color{
        var color : Color = Color.black
            
        if(cat=="Général"){
            color = Color.green
        }
        if(cat=="Dans la rue"){
            color = Color.orange
        }
        if(cat=="Au travail"){
            color = Color.red
        }
        if(cat=="Dans les transports"){
            color = Color.blue
        }
        if(cat=="En famille"){
            color = Color.purple
        }
        return color
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
    
    func like(reponse : Reponse) {
        self.reponseDAO.addLike(rep: reponse, idRemarque: remarque._id, user : self.myPersonne[0].pseudo!, completionHandler: {
            res in
            if (!res) {
                print("erreur lors de l'ajout de like")
            }
        })
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
            return reponseDAO.answers.filter{$0.user == myPersonne[0].pseudo!}
        }
        else{
            return self.reponseDAO.answers
        }
    }
    
    func alreadyHeard() -> Bool {
        var res = false
        for obj in remarque.likes {
            if(obj["user"] == self.myPersonne[0].pseudo!){
                res = true
            }
        }
        return res
    }
    
//    func alreadyLiked() -> Bool {
//        var res = false
//        for obj in reponseDAO.ge {
//            if(obj["user"] == self.myPersonne[0].pseudo!){
//                res = true
//            }
//        }
//        return res
//    }
}

//struct RemarqueDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemarqueDetailView()
//    }
//}
