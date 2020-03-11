//
//  LikeWithoutId.swift
//  ProjetAppMobile
//
//  Created by etud on 11/03/2020.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class LikeWithoutId: Decodable, Identifiable, CustomStringConvertible{
    var user : String
    var description : String {return " \(self.user) "}
    
    
    init(idPersonne : String){
        self.user = idPersonne
    }
}
