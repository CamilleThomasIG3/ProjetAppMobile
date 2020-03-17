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
            self.currentRemarque = [res]
          }
        }.resume()
    }
    
    func addRemarque(remarque: RemarqueWithoutId, completionHandler: @escaping (Bool) -> ()) {
           
           guard let url = URL(string: urlRemarques) else { return }
           
           let newRemarque:[String: Any] = [
                "date" : remarque.date,
                "content" : remarque.content,
                "pseudo" : remarque.user,
                "idCategory" : remarque.idCategory
           ]
           
           let body = try! JSONSerialization.data(withJSONObject: newRemarque)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.httpBody = body
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data else { return }
               
            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

            if resData.res == "correct" {
                DispatchQueue.main.async {
                    completionHandler(true)
                }
            }
            else{
               DispatchQueue.main.async {
                    completionHandler(false)
                }
            }
           }.resume()
       }

    
    func deleteRemarque(id : String){
         guard let url = URL(string: urlRemarques+id) else { return }
         
         var request = URLRequest(url: url)
         request.httpMethod = "DELETE"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
         URLSession.shared.dataTask(with: request) { (data, response, error) in

             guard let data = data else { return }
             
             let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

            print(resData.msg)
         }.resume()
    }
    
    //A FAIRE
//    func getRemarquesOfPersonne(idPersonne : String){}
//    func getRemarquesOfCategorie(idCategorie : String) -> [Remarque] {}

}
