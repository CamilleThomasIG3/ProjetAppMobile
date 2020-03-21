//
//  Reponse.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Reponse: Decodable, Identifiable, CustomStringConvertible{
    var _id : String
    var date : String
    var content : String
    var user : String
    var categoryResponse : String
    var likes : [[String:String]] = [[:]]
    var description : String {return " \(self.content) "}
    
    
    init(id : String, date : String, contenu : String, idPersonne : String, idCategorieReponse : String){
        self._id = id
        self.date = date
        self.content = contenu
        self.user = idPersonne
        self.categoryResponse = idCategorieReponse
        
    }
}
