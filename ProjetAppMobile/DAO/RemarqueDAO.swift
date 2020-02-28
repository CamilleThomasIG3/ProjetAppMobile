//
//  RemarqueDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class RemarqueDAO {
    func getRemarque(id : String) -> RemarqueDAO
    func getPersonne(id :String) -> String
    func getContenu(id : String) -> String
    
    func setPersonne(id : String, idPersonne : String)
    func setContenu(id : String, contenu : String)
    
    func addRemarque(r : Remarque)
    func deleteRemarque(id : String)
    func count() -> Int
}
