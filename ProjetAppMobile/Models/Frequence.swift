//
//  Frequence.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Frequence{
    private var id : String
    private var idPersonne : String
    private var idRemarque : String
    
    init(id : String, idPersonne : String, idRemarque : String) {
        self.id = id
        self.idPersonne = idPersonne
        self.idRemarque = idRemarque
    }
    
    func getId() -> String {}
    func getPersonne(id : String) -> String {}
    func getRemarque(id : String) -> String {}
    
    func setPersonne(id : String, personne : String) {}
    func setRemarque(id : String, remarque : String) {}
}
