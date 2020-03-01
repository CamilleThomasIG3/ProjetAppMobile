//
//  Avis.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/1/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Avis {
    private var id : String
    private var idPersonne : String
    private var idReponse : String
    private var label : Bool // correspond à un "like" si true et à un signalement si false

    init(id : String, idPersonne : String, idReponse : String, label : Bool){
        self.id = id
        self.idPersonne = idPersonne
        self.idReponse = idReponse
        self.label = label
    }


    func getId() -> String {
        return self.id
    }

    func getidPersonne() -> String{
        return self.idPersonne
    }

    func getidReponse() -> String{
        return self.idReponse
    }

    func getlabel() -> Bool {
        return self.label
    }


    func setidPersonne(idPersonne : String) {
        self.idPersonne = idPersonne
    }

    func setidReponse(idReponse : String){
        self.idReponse = idReponse
    }

    func setlabel(label : Bool) {
        self.label = label
    }

    func setAvis(idPersonne : String, idReponse : String, label : Bool){
        self.idPersonne = idPersonne
        self.idReponse = idReponse
        self.label = label
    }
}
