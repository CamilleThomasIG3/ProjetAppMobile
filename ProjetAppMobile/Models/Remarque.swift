//
//  Remarque.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import SwiftUI

class Remarque: Decodable, Identifiable, CustomStringConvertible{
    var _id : String
    var title : String
    var date : String
    var content : String
    var user : String
    var idCategory : String
    var likes : [[String:String]] = [[:]]
    var nbLikes : Int
    var description: String {return " \(self.title) "}
    private enum CodingKeys: String, CodingKey { case _id, title, date, content, user, idCategory, likes }
    
    init(){
        self._id = ""
        self.title = ""
        self.date = ""
        self.content = ""
        self.user = ""
        self.idCategory = ""
        self.nbLikes = 0
    }
    
    init(id : String, title : String, date : String, content : String, user : String, idCategory : String){
        self._id = id
        self.title = title
        self.date = date
        self.content = content
        self.user = user
        self.idCategory = idCategory
        self.nbLikes = 0
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decode(String.self, forKey: ._id)
        title = try container.decode(String.self, forKey: .title)
        date = try container.decode(String.self, forKey: .date)
        content = try container.decode(String.self, forKey: .content)
        user = try container.decode(String.self, forKey: .user)
        idCategory = try container.decode(String.self, forKey: .idCategory)
        likes = try container.decode([[String:String]].self, forKey: .likes)
        nbLikes = likes.count
    }
}
