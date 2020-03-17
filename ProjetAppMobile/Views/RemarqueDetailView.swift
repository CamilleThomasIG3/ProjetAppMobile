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
    
    @ObservedObject var reponseDAO = ReponseDAO()
    var remarque : Remarque
    
    @Binding var estConnecte : Bool
    @State private var showingAlert = false
    
    init(remarque: Remarque, estConnecte : Binding<Bool>){
        self.remarque = remarque
        self._estConnecte = estConnecte
        //reponseDAO.getAnswers(idRemarque: remarque._id)
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
            }
            
            VStack{
                //Barre Réponses
                ZStack {
                    Rectangle().fill(Color(UIColor(named: "Gris_clair")!)).frame(height:40)
                    Text("Réponses").multilineTextAlignment(.leading)
                }

                Picker(selection: $selectedCat, label: Text("Tri")) {
                    ForEach(0 ..< cats.count){
                        Text(self.cats[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }.padding(20)
            
          //  Liste réponses
            List {
                ForEach(reponseDAO.answers){ answer in
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
                            
                            Text("\(answer.likes.count)").padding(.trailing, 10)
                            
                            Button(action: {
                                self.like(reponse : answer)
                                
                            })
                            {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5).fill(Color("Gris_fonce")).frame(width: 40, height:40)
                                    Image("coeur").resizable().frame(width: 30, height: 30, alignment : .trailing)
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
        self.reponseDAO.addLike(rep: reponse, idRemarque: remarque._id)
    }
}

//struct RemarqueDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemarqueDetailView()
//    }
//}
