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
    
    let urlRemarques : String = "https://against-sexism.herokuapp.com/api/remarks/"
    
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
                "title": remarque.title,
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
    
    func addFrequence(id : String, user : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string : urlRemarques+id+"/likes") else { return }
        let newLike : [String: Any] = [
                       "pseudo": user
                  ]
                  
                  let body = try! JSONSerialization.data(withJSONObject: newLike)
                  
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
    
    func deleteFrequence(idRemarque : String, pseudo : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/userlike/"+pseudo) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            _ = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
        }.resume()
    }
    
    //SIGNAL
    func addSignal(remarque : Remarque, pseudoUser : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string : urlRemarques+remarque._id+"/signals") else { return }
        
        let newSignal : [String: Any] = [
            "pseudo": pseudoUser
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: newSignal)
        
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
    
    
    func deleteSignal(idRemarque : String, pseudo : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/usersignal/"+pseudo) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            _ = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
        }.resume()
    }

}
