//
//  Remarque.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import SwiftUI

class RemarkWithAnswers: Decodable, Identifiable, CustomStringConvertible{
    var _id : String
    var date : String
    var content : String
    var user : String
    var idCategory : String
    var description: String {return " \(self.content) "}
    var answers : [Reponse]
    
    init(id : String, date : String, content : String, user : String, idCategory : String, answers : [Reponse]){
        self._id = id
        self.date = date
        self.content = content
        self.user = user
        self.idCategory = idCategory
        self.answers = answers
    }
}
