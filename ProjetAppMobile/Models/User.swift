//
//  Personne.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//
import Foundation

class User : Decodable, Identifiable, CustomStringConvertible {
    
    var _id: String
    var pseudo: String
    var email: String
    var password: String
    var register_date: String
    var admin : Bool
    var description: String {return " \(self.pseudo) "}
    
    
    init(id : String, email : String, pseudo : String, password : String, date:String){
        self._id = id
        self.email = email
        self.pseudo = pseudo
        self.password = password
        self.register_date = date
        self.admin = false
    }
}
