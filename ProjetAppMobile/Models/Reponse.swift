//
//  Reponse.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Reponse{
    private var id : String
    private var date : String
    private var contenu : String
    private var idPersonne : String
    private var idRemarque : String
    private var idCategorieReponse : String
    
    
    init(id : String, date : String, contenu : String, idPersonne : String, idRemarque : String, idCategorieReponse : String){
        self.id = id
        self.date = date
        self.contenu = contenu
        self.idPersonne = idPersonne
        self.idRemarque = idRemarque
        self.idCategorieReponse = idCategorieReponse
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
    
    func getIdRemarque() -> String {
        return self.idRemarque
    }
    
    func getIdCategorieReponse() -> String {
        return self.idCategorieReponse
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
    
    func setIdRemarque(idRemarque : String) {
        self.idRemarque = idRemarque
    }
    
    func setIdCategorieReponse(idCategorieReponse : String) {
        self.idCategorieReponse = idCategorieReponse
    }
    
    func setReponse(date : String, contenu : String, idPersonne : String, idRemarque : String, idCategorieReponse : String){
        self.date = date
        self.contenu = contenu
        self.idPersonne = idPersonne
        self.idRemarque = idRemarque
        self.idCategorieReponse = idCategorieReponse
    }
}
