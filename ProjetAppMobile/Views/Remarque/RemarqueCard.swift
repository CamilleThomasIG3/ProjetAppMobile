//
//  RemarqueCard.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct RemarqueCard: View {
    @Environment(\.presentationMode) var presentation
    
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: PersonneApp.entity(),
        sortDescriptors: []
    )
    var myPersonne : FetchedResults<PersonneApp>
    
    @State var pseudo : String = ""
    
    @ObservedObject var remarqueDAO = RemarqueDAO()
    var remarque : Remarque
    @Binding var estConnecte : Bool
    
    @State private var isHiddenEntendu = false
    @State private var isHiddenSignalementRmq = false
    
    var body: some View {
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
            
            //Buttons "déjà entendu", "supprimer" et "signalement"
            HStack {
                if (self.estConnecte) {
                    //Button "déjà entendu" pas encore cliqué
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
                    //Button "déjà entendu" déjà cliqué
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
                    //Boutton "supprimé" si c'est la remarque de la personne connectée
                    if(remarque.user == self.pseudo){
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(Color.red).frame(width: 130, height:30)
                            Text("Supprimer").foregroundColor(Color.white).bold().padding(5).onTapGesture {
                                self.remarqueDAO.deleteRemarque(id: self.remarque._id)
                                self.presentation.wrappedValue.dismiss()
                            }
                        }
                    }else{//que si pas la remarque de la personne conenctée
                        //Button "signalement" pas encore cliqué
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
                         //Button "signalement" déjà cliqué
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
    }
    
    //retourne vrai si la remarque a déjà été entendu par la personne connectée, faux sinon
    func alreadyHeard() -> Bool {
        var res = false
        for obj in remarque.likes {
            if(estConnecte && obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
    
    //retourne vrai si la remarque a déjà été signalé par la personne connectée, faux sinon
    func alreadySignaledRemarque() -> Bool {
        var res = false
        for obj in remarque.signals {
            if(obj["user"] == self.pseudo){
                res = true
            }
        }
        return res
    }
    
    //Retourne la couleur correspondant à la catégorie passée en paramètre
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
    
}
