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
    @State private var isHiddenAimeRps = false
    @State private var isHiddenSignalementRmq = false
    @State private var isHiddenSignalementRps = false
    
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    @State var pseudo : String = ""
    
    @State var showingCategories = false
    @State var activeBoxes : [String:Bool]  = ["Général":false, "Humour":false, "Loi":false, "Citation":false]
    
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
                        Text(remarque.idCategory).padding(20).foregroundColor(self.getColorCategoryRemarque(cat: remarque.idCategory))
                        Spacer()
                        Text(self.convertDate(date : remarque.date)).padding(20)
                    }
                }
                Text(remarque.content).multilineTextAlignment(.center).padding(10)
                
                //Button déjà entendu, supprimer remarque et signalement
                HStack {
                    if (self.estConnecte) {
                        if (!self.alreadyHeard() && !self.isHiddenEntendu) {
                            Button(action: {
                                self.remarqueDAO.addFrequence(id: self.remarque._id, user: self.pseudo, completionHandler: {
                                    res in
                                    if (!res) {
                                        print("erreur lors de l'ajout de fréquence")
                                    }
                                })
                                self.isHiddenEntendu = true
                            })
                            {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.blue).frame(width: 130, height:30)
                                    Text("Déjà entendu").foregroundColor(Color.white).bold().padding(5)
                                }
                            }
                        }
                        else if(self.alreadyHeard() || self.isHiddenEntendu){
                             Button(action: {
                                self.remarqueDAO.deleteFrequence(idRemarque: self.remarque._id, pseudo: self.pseudo)
                                self.isHiddenEntendu = false
                            })
                            {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.blue).opacity(0.5).frame(width: 130, height:30).opacity(0.5)
                                    Text("Déjà entendu").foregroundColor(Color.white).bold().padding(5)
                                }
                            }
                        }
                        if(remarque.user == self.pseudo){
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color.red).frame(width: 130, height:30)
                                Text("Supprimer").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                    self.remarqueDAO.deleteRemarque(id: self.remarque._id)
                                    self.presentation.wrappedValue.dismiss()                                    
                                }
                            }
                        }else{
                            //pas encore signalé
                            if(!self.alreadySignaledRemarque() && !self.isHiddenSignalementRmq){
                                Button(action: {
                                    self.remarqueDAO.addSignal(remarque: self.remarque, pseudoUser: self.pseudo, completionHandler: {
                                        res in
                                        if (!res) {
                                            print("erreur lors de l'ajout du signalement")
                                        }
                                    })
                                    self.isHiddenSignalementRmq = true
                                })
                                {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color.orange).frame(width: 130, height:30)
                                        Text("Signaler").foregroundColor(Color.white).bold().padding(5)
                                    }
                                }
                                //deja signalé
                            }else if(self.alreadySignaledRemarque() || self.isHiddenSignalementRmq){
                                Button(action: {
                                    self.remarqueDAO.deleteSignal(idRemarque: self.remarque._id, pseudo: self.pseudo)
                                    self.isHiddenSignalementRmq = false
                                })
                                {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color.orange).frame(width: 130, height:30).opacity(0.5)
                                        Text("Signaler").foregroundColor(Color.white).bold().padding(5)
                                    }
                                }
                            }
                        }
                    }
                }
            }.onAppear{
                if(self.estConnecte){
                    self.pseudo = self.myPersonne[0].pseudo!
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
                        RadioButton(text: "Général", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Général"))
                        RadioButton(text: "Humour", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Humour"))
                        RadioButton(text: "Loi", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Loi"))
                        RadioButton(text: "Citation", boxes : self.$activeBoxes).foregroundColor(self.getColorCategoryReponse(cat: "Citation"))
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
                                //BOUTON SIGNAL
                                
                                //pas encore signalé
                                if(self.estConnecte && !self.alreadySignaled(answer: answer)){
                                    Button(action: {
                                        self.signal(reponse : answer)
                                    })
                                    {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                            Image("warning-black").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                        }
                                        
                                    }.padding(.leading, 10)
                                //deja signalé
                                }else if(self.estConnecte && self.alreadySignaled(answer: answer)){
                                    Button(action: {
                                        self.reponseDAO.deleteSignal(idRep: answer._id, idRemarque: self.remarque._id, pseudo: self.pseudo)
                                    })
                                    {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                            Image("warning").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                        }
                                        
                                    }.padding(.leading, 10)
                                //pas connecté
                                }else{
                                    Button(action: {self.showingAlertSignal=true})
                                    {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                            Image("warning-black").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                        }
                                    }.alert(isPresented: self.$showingAlertSignal){
                                        Alert(title: Text("Vous n'êtes pas connecté !"),
                                              message: Text("La connexion est obligatoire pour signaler une réponse"),
                                              dismissButton: .default(Text("J'ai compris")))
                                    }.padding(.leading, 10)
                                }
                                
                                
                                Spacer()
                                
                                //Boutton supprimer si la reponse de la personne connectée
                                if(self.estConnecte && answer.user == self.pseudo){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color.red).frame(width: 130, height:30)
                                        Text("Supprimer").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                            self.reponseDAO.deleteReponseById(idRep: answer._id, idRemarque: self.remarque._id)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                Text("\(answer.likes.count)").padding(.trailing, 10)
                                
                                //BOUTON LIKE
                                
                                //pas encore liké
                                if(self.estConnecte && !self.alreadyLiked(answer: answer)){
                                    Button(action: {
                                        self.like(reponse : answer)
                                    })
                                    {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                            Image("coeur-black").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                        }
                                        
                                    }
                                    //deja liké
                                }else if(self.estConnecte && self.alreadyLiked(answer: answer)){
                                    Button(action: {
                                        self.reponseDAO.deleteLike(idRep: answer._id, idRemarque: self.remarque._id, pseudo: self.pseudo)
                                    })
                                    {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                            Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
                                        }
                                        
                                    }
                                    //pas connecté
                                }else{
                                    Button(action: {self.showingAlertAime=true})
                                    {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                            Image("coeur-black").resizable().frame(width: 30, height: 30, alignment : .trailing)
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
        self.reponseDAO.addLike(rep: reponse, idRemarque: remarque._id, user : self.pseudo, completionHandler: {
            res in
            if (!res) {
                print("erreur lors de l'ajout de like")
            }
        })
    }
    
    func signal(reponse : Reponse) {
        self.reponseDAO.addSignal(rep: reponse, idRemarque: remarque._id, user : self.pseudo, completionHandler: {
            res in
            if (!res) {
                print("erreur lors de l'ajout du signalement")
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
            return reponseDAO.answers.filter{$0.user == pseudo}
        }
        else{
            return self.reponseDAO.answers
        }
    }
    
    func alreadyHeard() -> Bool {
        var res = false
        for obj in remarque.likes {
            if(estConnecte && obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
    
    func alreadyLiked(answer : Reponse) -> Bool {
        var res = false
        for obj in answer.likes {
            if(obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
    
    func alreadySignaled(answer : Reponse) -> Bool {
        var res = false
        for obj in answer.signals {
            if(obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
        
    func alreadySignaledRemarque() -> Bool {
        var res = false
        for obj in remarque.signals {
            if(obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }

}

//struct RemarqueDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemarqueDetailView()
//    }
//}
