//
//  Personne.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Personne {
    private var id : String
    private var email : String
    private var pseudo : String
    private var mdp : String
    
    init(id : String, email : String, pseudo : String, mdp : String){
        self.id = id
        self.email = email
        self.pseudo = pseudo
        self.mdp = mdp
    }
    
    
    func getId() -> String {
        return self.id
    }
    
    func getEmail() -> String{
        return self.email
    }
    
    func getPseudo() -> String{
        return self.pseudo
    }
    
    func getMdp() -> String {
        return self.mdp
    }
    
    
    func setEmail(email : String) {
        self.email = email
    }
    
    func setPseudo(pseudo : String){
        self.pseudo = pseudo
    }
    
    func setMdp(mdp : String) {
        self.mdp = mdp
    }
    
    
    func setPersonne(email : String, pseudo : String, mdp : String){
        self.email = email
        self.pseudo = pseudo
        self.mdp = mdp
    }
}
