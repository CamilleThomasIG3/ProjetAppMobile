//
//  Reponse.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class ReponseWithoutId: Decodable, Identifiable, CustomStringConvertible{
    var date : String
    var content : String
    var user : String
    var categoryResponse : String
    var likes : [[String:String]] = [[:]]
    var signals : [[String:String]] = [[:]]
    var description : String {return " \(self.content) "}
    
    
    init(date : String, contenu : String, idPersonne : String, idCategorieReponse : String){
        self.date = date
        self.content = contenu
        self.user = idPersonne
        self.categoryResponse = idCategorieReponse
        
    }
}
