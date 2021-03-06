//
//  Remarque.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import SwiftUI

class RemarqueWithoutId: Decodable, Identifiable, CustomStringConvertible{

    var date : String
    var title : String
    var content : String
    var user : String
    var idCategory : String
    var description: String {return " \(self.title) "}
    
    
    init(title : String, date : String, content : String, user : String, idCategory : String){
        self.title = title
        self.date = date
        self.content = content
        self.user = user
        self.idCategory = idCategory
    }
}
