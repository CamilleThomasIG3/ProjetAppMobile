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
    
    
    func getId() -> String {
            return id
    }
    
    func getIdPersonne() -> String {
        return idPersonne
    }
    
    func getIdRemarque() -> String {
        return idRemarque
    }
    
    
    func setIdPersonne(idPersonne : String) {
        self.idPersonne = idPersonne
    }
    
    func setIdRemarque(idRemarque : String) {
        self.idRemarque = idRemarque
    }
    
    func setFrequence(idPersonne : String, idRemarque : String){
        self.idPersonne = idPersonne
        self.idRemarque = idRemarque
    }
}
