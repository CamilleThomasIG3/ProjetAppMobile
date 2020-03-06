//
//  ReponseDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/1/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class ReponseDAO : ObservableObject {
    
    @Published var currentRemarque = [Remarque]()
    @Published var answers = [Reponse]()
    private var idRemarque : String
    let urlRemarques : String = "https://whispering-river-73122.herokuapp.com/api/remarks/"
    
    init(idRemarque : String){
        self.idRemarque = idRemarque
    }
    
    func getAnswers(){
        guard let url = URL(string: urlRemarques+self.idRemarque+"/answers") else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode(Reponse.self, from: data)
          DispatchQueue.main.async{
            print(res)
            self.answers = [res]
            print(res.content)
          }
        }.resume()
    }
    
   
//    func getReponse(id : String) -> Reponse {}
//    func getRemarque(id :String) -> String {}
//    func getContenu(id : String) -> String {}
//    func getDate(id : String) -> String {}
//    func getCategorie(id : String) -> String {}
//    func getPersonne(id : String) -> String {}
//    
//    func setDate(id : String) {}
//    func setRemarque(id : String, idRemarque : String) {}
//    func setContenu(id : String, contenu : String) {}
//    func setCategorie(id : String, categorie : String ) {}
//    func setPersonne(id :String, personne :String) {}
//    
//    func addReponse(r : Reponse) {}
//    func deleteReponse(id : String) {}
//    func getAllReponses() -> [Reponse] {}
//    func getReponsesWithCategorie(categorie : String) -> [Reponse] {}
//    func getReponsesWithRemarque(idRemarque : String) -> [Reponse] {}
//    func getReponsesWithPersonne(idPersonne :String) -> [Reponse] {}
//    func getReponsesByDate(date : String) -> [Reponse] {}
//    //fonctions pour tri par rapport à la date ???
//    func count() -> Int {}
}
