//
//  ReponseDetail.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct ReponseDetail: View {
    var answer : Reponse
    var remarque : Remarque
    
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    @Binding var estConnecte : Bool
    
    @ObservedObject var reponseDAO = ReponseDAO()
    
    @State private var showingAlertAime = false
    @State private var showingAlertSignal = false
    
    @State private var isHiddenAimeRps = false
    @State private var isHiddenSignalementRps = false
    
    @State var pseudo : String = ""
    
    var body: some View {
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
                    //Boutton "signalement" si la personne connectée ne l'a pas encore signalé
                    if(self.estConnecte && !self.alreadySignaled(answer: answer) && !self.isHiddenSignalementRps){
                        Button(action: {
                            self.signal(reponse : self.answer)
                            self.isHiddenSignalementRps = true
                        })
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                Image("warning-black").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                            
                        }.padding(.leading, 10)
                    //Boutton "signalement" si la personne connectée l'a déjà signalé
                    }else if(self.estConnecte && self.alreadySignaled(answer: answer) || self.isHiddenSignalementRps){
                        Button(action: {
                            self.reponseDAO.deleteSignal(idRep: self.answer._id, idRemarque: self.remarque._id, pseudo: self.pseudo)
                            self.isHiddenSignalementRps = false
                        })
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                Image("warning").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                            
                        }.padding(.leading, 10)
                    //Le boutton "signalement" affiche un message d'erreur si la personne n'est pas connectée
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
                    
                    //Le boutton "supprimer" s'affiche si c'est la personne connectée qui a posté cette réponse
                    if(self.estConnecte && answer.user == self.pseudo){
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(Color.red).frame(width: 130, height:30)
                            Text("Supprimer").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                self.reponseDAO.deleteReponseById(idRep: self.answer._id, idRemarque: self.remarque._id)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Text("\(answer.likes.count)").padding(.trailing, 10)
                    
                    //Boutton "J'aime" si la personne connectée n'a pas encore aimé la réponse
                    if(self.estConnecte && !self.alreadyLiked(answer: answer) && !self.isHiddenAimeRps){
                        Button(action: {
                            self.like(reponse : self.answer)
                            self.isHiddenAimeRps = true
                        })
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                Image("coeur-black").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                            
                        }
                     //Boutton "J'aime" si la personne connectée a déjà aimé la réponse
                    }else if(self.estConnecte && self.alreadyLiked(answer: answer) || self.isHiddenAimeRps){
                        Button(action: {
                            self.reponseDAO.deleteLike(idRep: self.answer._id, idRemarque: self.remarque._id, pseudo: self.pseudo)
                            self.isHiddenAimeRps = false
                        })
                        {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
                            }
                            
                        }
                    //Le boutton "J'aime" affiche un message d'erreur si la personne n'est pas connectée
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
        .onAppear{
            if(self.estConnecte){
                self.pseudo = self.myPersonne[0].pseudo!
            }
        }
    }
    
    //Convertit la date dans un format plus lisible
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
    
    //l'utilisateur connecté aime la réponse en paramètre
    func like(reponse : Reponse) {
        self.reponseDAO.addLike(rep: reponse, idRemarque: remarque._id, user : self.pseudo, completionHandler: {
            res in
            if (!res) {
                print("erreur lors de l'ajout de like")
            }
        })
    }
    
    //l'utilisateur connecté signale la réponse en paramètre
    func signal(reponse : Reponse) {
        self.reponseDAO.addSignal(rep: reponse, idRemarque: remarque._id, user : self.pseudo, completionHandler: {
            res in
            if (!res) {
                print("erreur lors de l'ajout du signalement")
            }
        })
    }

    //retourne vrai si la remarque a déjà aimé par la personne connectée, faux sinon
    func alreadyLiked(answer : Reponse) -> Bool {
        var res = false
        for obj in answer.likes {
            if(obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
    
    //retourne vrai si la remarque a déjà signalé par la personne connectée, faux sinon
    func alreadySignaled(answer : Reponse) -> Bool {
        var res = false
        for obj in answer.signals {
            if(obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
    
    //Retourne la couleur correspondant à la catégorie passée en paramètre
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
}
