//
//  Remarque.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import SwiftUI

class Remarque : Codable, ObservableObject{
    @Published private var id : String
    @Published private var date : Date
    @Published private var contenu : String
    @Published private var idPersonne : String
    @Published private var idCategorieRemarque : String
    
    
    init(id : String, date : Date, contenu : String, idPersonne : String, idCategorieRemarque : String){
        self.id = id
        self.date = date
        self.contenu = contenu
        self.idPersonne = idPersonne
        self.idCategorieRemarque = idCategorieRemarque
    }
    
    private enum CodingKeys : String, CodingKey{
        case id = "_id"
        case date = "date"
        case contenu = "content"
        case idPersonne = "User"
        case idCategorieRemarque = "idCategory"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.contenu = try container.decode(String.self, forKey: .contenu)
        self.idPersonne = try container.decode(String.self, forKey: .idPersonne)
        self.idCategorieRemarque = try container.decode(String.self, forKey: .idCategorieRemarque)
        
        let isodate : String = try container.decode(String.self, forKey: .date)
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        self.date = dateF.date(from: isodate.components(separatedBy: ".")[0])!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(contenu, forKey: .contenu)
        try container.encode(idPersonne, forKey: .idPersonne)
        try container.encode(idCategorieRemarque, forKey: .idCategorieRemarque)
    }
    
    
    
    func getId() -> String {
        return self.id
    }
    
    func getDate() -> Date{
        return self.date
    }
    
    func getContenu() -> String{
        return self.contenu
    }
    
    func getIdPersonne() -> String {
        return self.idPersonne
    }
    
    func getIdCategorieRemarque() -> String {
        return self.idCategorieRemarque
    }
    
    
    func setDate(date : Date) {
        self.date = date
    }
    
    func setContenu(contenu : String){
        self.contenu = contenu
    }
    
    func setIdPersonne(idPersonne : String) {
        self.idPersonne = idPersonne
    }
    
    func setIdCategorieRemarque(idCategorieRemarque : String) {
        self.idCategorieRemarque = idCategorieRemarque
    }
    
    func setRemarque(date : Date, contenu : String, idPersonne : String, idCategorieRemarque : String){
        self.date = date
        self.contenu = contenu
        self.idPersonne = idPersonne
        self.idCategorieRemarque = idCategorieRemarque
    }
}
