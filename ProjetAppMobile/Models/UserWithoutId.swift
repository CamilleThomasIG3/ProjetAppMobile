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
    var description: String {return " \(self.pseudo) "}
    
    init() {
        self.pseudo = ""
        self.email = ""
        self.password = ""
    }
    
    init(email : String, pseudo : String, password : String){
        self.email = email
        self.pseudo = pseudo
        self.password = password
    }
}
