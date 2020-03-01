//
//  CategorieReponse.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class CategorieReponse{
    private var id : String
    private var label : String
    
    
    init(id : String, label : String){
        self.id = id
        self.label = label
    }
    
    
    func getId() -> String{
        return self.id
    }
    
    func getLabel() -> String{
        return self.label
    }
    
    
    func setLabel(label : String){
        self.label = label
    }
}
