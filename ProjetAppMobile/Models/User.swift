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
    var register_date: Date
    var description: String {return " \(self.pseudo) "}
    
    
    
    
    
    init(id : String, email : String, pseudo : String, password : String){
        self._id = id
        self.email = email
        self.pseudo = pseudo
        self.password = password
        self.register_date = Date.init()
    }
    
//    private enum CodingKeys : String, CodingKey{
//        case id = "_id"
//        case email = "email"
//        case pseudo = "pseudo"
//        case mdp = "password"
//    }
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.email = try container.decode(String.self, forKey: .email)
//        self.pseudo = try container.decode(String.self, forKey: .pseudo)
//        self.mdp = try container.decode(String.self, forKey: .mdp)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(email, forKey: .email)
//        try container.encode(pseudo, forKey: .pseudo)
//        try container.encode(mdp, forKey: .mdp)
//    }
//
//    func getId() -> String {
//        return self._id
//    }
//
//    func getEmail() -> String{
//        return self.email
//    }
//
//    func getPseudo() -> String{
//        return self.pseudo
//    }
//
//    func getMdp() -> String {
//        return self.password
//    }
//
//
//    func setEmail(email : String) {
//        self.email = email
//    }
//
//    func setPseudo(pseudo : String){
//        self.pseudo = pseudo
//    }
//
//    func setMdp(mdp : String) {
//        self.password = mdp
//    }
//
//
//    func setPersonne(email : String, pseudo : String, mdp : String){
//        self.email = email
//        self.pseudo = pseudo
//        self.password = mdp
//    }
}
