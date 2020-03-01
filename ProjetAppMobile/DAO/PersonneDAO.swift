//
//  UserDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class PersonneDAO{
    func getPersonne(id : String) -> Personne {}
    func getEmail(id : String) -> String {}
    func getPseudo(id : String) -> String {}
    func getMdP(id : String) -> String {}
    
    func setEmail(id : String, email : String) {}
    func setPseudo(id : String, pseudo : String) -> String {}
    func setMdp(id : String, mdp : String) -> String {}
    
    func addPersonne(p : Personne) {}
    func deletePersonne(id : String) {}
    func count() -> Int {}
}
