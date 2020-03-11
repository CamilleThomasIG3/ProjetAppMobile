//
//  Like.swift
//  ProjetAppMobile
//
//  Created by etud on 11/03/2020.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class Like: Decodable, Identifiable, CustomStringConvertible{
    var _id : String
    var user : String
    var description : String {return " \(self.user) "}
    
    
    init(id : String, idPersonne : String){
        self._id = id
        self.user = idPersonne
    }
}
