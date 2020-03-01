//
//  Remarque.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Remarque{
    private var id : String
    private var date : String
    private var contenu : String
    private var idPersonne : String
    private var idCategorieRemarque : String
    
    
    init(id : String, date : String, contenu : String, idPersonne : String, idCategorieRemarque : String){
        self.id = id
        self.date = date
        self.contenu = contenu
        self.idPersonne = idPersonne
        self.idCategorieRemarque = idCategorieRemarque
    }
    
    
    func getId() -> String {
        return self.id
    }
    
    func getDate() -> String{
        return self.date
    }
    
    func getContenu() -> String{
        return self.contenu
    }
    
    func getIdPersonne() -> String {
        return self.idPersonne
    }
    
    func getIdCategorieRemarque() -> String {
        return self.idCategorieRemarque
    }
    
    
    func setDate(date : String) {
        self.date = date
    }
    
    func setContenu(contenu : String){
        self.contenu = contenu
    }
    
    func setIdPersonne(idPersonne : String) {
        self.idPersonne = idPersonne
    }
    
    func setIdCategorieRemarque(idCategorieRemarque : String) {
        self.idCategorieRemarque = idCategorieRemarque
    }
    
    func setRemarque(date : String, contenu : String, idPersonne : String, idCategorieRemarque : String){
        self.date = date
        self.contenu = contenu
        self.idPersonne = idPersonne
        self.idCategorieRemarque = idCategorieRemarque
    }
}
