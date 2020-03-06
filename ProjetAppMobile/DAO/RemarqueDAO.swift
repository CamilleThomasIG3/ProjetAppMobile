//
//  RemarqueDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class RemarqueDAO : ObservableObject{
    @Published var remarques = [Remarque]()
    @Published var currentRemarque = [Remarque]()
    
    let urlRemarques : String = "https://whispering-river-73122.herokuapp.com/api/remarks/"
    
    init() {
        getAllRemaques()
    }

    
    func getAllRemaques(){
        guard let url = URL(string: urlRemarques) else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([Remarque].self, from: data)
          DispatchQueue.main.async{
            self.remarques = res
          }
        }.resume()
    }
    
    
    func getRemarqueById(id : String){
        guard let url = URL(string: urlRemarques+id) else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode(Remarque.self, from: data)
          DispatchQueue.main.async{
            print(res)
            self.currentRemarque = [res]
            print(res.content)
          }
        }.resume()
    }
    
    
    func getRemarquesOfPersonne(idPersonne : String){
        
    }
    
    
    func deleteRemarque(id : String){
       
    }
    
    //A FAIRE
//    func addRemarque(r : Remarque)->Bool {}
//    func getRemarquesOfCategorie(idCategorie : String) -> [Remarque] {}

}
