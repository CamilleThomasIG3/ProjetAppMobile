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
    let urlRemarques : String = "https://whispering-river-73122.herokuapp.com/api/remarks/"

    func getAnswers(idRemarque : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/answers") else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([Reponse].self, from: data)
          DispatchQueue.main.async{
            self.answers = res
          }
        }.resume()
    }
    
    func addReponse(r : ReponseWithoutId, idRemarque : String) {
        guard let url = URL(string: urlRemarques+idRemarque+"/answers") else { return }
            
            let newReponse:[String: Any] = [
                "date" : r.date,
                "content" : r.content,
                "pseudo" : r.user,
                "categoryResponse" : r.categoryResponse,
                "likes" : r.likes,
                
            ]
            
            let body = try! JSONSerialization.data(withJSONObject: newReponse)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in

//             guard let data = data else { return }
                
//             let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

//             print(resData.msg+" ici!!")
            }.resume()
        }
    
    func deleteAllReponse(idRemarque : String) {
        guard let url = URL(string: urlRemarques+idRemarque+"/answers") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

//            guard let data = data else { return }
            
//            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

//           print(resData.msg)
        }.resume()
    }
    
    func deleteReponseById(idRep : String, idRemarque : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/answers?_id=5e63b8d98422600017503179") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

//            guard let data = data else { return }
//            
//            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

//           print(resData.msg)
        }.resume()
    }
    
    func getReponsesWithCategorie(categorie : String, idRemarque : String) /*-> [Reponse]*/ {
        guard let url = URL(string: urlRemarques+idRemarque+"/answers?categoryResponse="+categorie) else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([Reponse].self, from: data)
          DispatchQueue.main.async{
            print(res)
            self.answers = res
           // print(res.content)
          }
        }.resume()
    }
    
    func getReponsesWithPersonne(idPersonne :String, idRemarque : String) /*-> [Reponse]*/ {
        guard let url = URL(string: urlRemarques+idRemarque+"/answers?user="+idPersonne) else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([Reponse].self, from: data)
          DispatchQueue.main.async{
            print(res)
            self.answers = res
           // print(res.content)rrr
            
          }
        }.resume()
    }
    
    func addLike(rep : Reponse, idRemarque : String) {
        guard let url = URL(string: urlRemarques+idRemarque+"/answers/"+rep._id) else { return}
        let userLike = "useravoir"
        let body = try! JSONSerialization.data(withJSONObject: userLike)
              
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              request.httpBody = body
              request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              
            URLSession.shared.dataTask(with: request) { (data, response, error) in

               guard let data = data else { return }
                  
               let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

               print(resData.msg+" ici!!")
              }.resume()        
    }
    
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

