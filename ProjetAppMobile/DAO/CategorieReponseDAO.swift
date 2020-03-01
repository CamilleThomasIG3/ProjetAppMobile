//
//  CategorieReponseDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/1/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class CategorieReponseDAO {
    func getCategorieReponse(id : String) -> CategorieReponse {}
    func getLabel(id : String) -> String {}
    
    func setLabel(id : String, label : String)
    
    func addCategorieReponse(catRep : CategorieReponse) {}
    func deleteCategorieReponse(id :String) {}
    func getAllCategoriesRep() -> [CategorieReponse] {}
    func getCategoriesRepWithLabel(label : String) -> [CategorieReponse] {}
    func count() -> Int {}
    
}
