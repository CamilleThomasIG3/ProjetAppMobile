//
//  Personne.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//
import Foundation

class UserWithoutId : Decodable, Identifiable, CustomStringConvertible {
    
    var pseudo: String
    var email: String
    var password: String
    var register_date: String
    var description: String {return " \(self.pseudo) "}
    
    init(email : String, pseudo : String, password : String, date:String){
        self.email = email
        self.pseudo = pseudo
        self.password = password
        self.register_date = date
    }
}
