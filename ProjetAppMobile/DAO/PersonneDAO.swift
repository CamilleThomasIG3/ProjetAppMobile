//
//  UserDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import BCrypt


struct ServerMessage: Decodable {
    let msg : String
    let res : String
    let token : String = ""
}

class PersonneDAO: ObservableObject{
    @Published var personnes = [User]()
    @Published var currentUser = [User]()
    
    var urlPersonnes : String = "https://whispering-river-73122.herokuapp.com/api/users/"
    
    init() {
        getAllPersonnes()
    }
    
    func getAllPersonnes() {
        guard let url = URL(string: urlPersonnes) else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([User].self, from: data)
          DispatchQueue.main.async{
            self.personnes = res
          }
        }.resume()
    }
    
    func getPersonneById(id : String, completionHandler: @escaping ([User]) -> ()) {
        guard let url = URL(string: urlPersonnes+id) else { return }
            URLSession.shared.dataTask(with: url){(data, _, _) in
              guard let data = data else { return }
              let res = try! JSONDecoder().decode(User.self, from: data)
              DispatchQueue.main.async{
                self.currentUser = [res]
                completionHandler([res])
              }
            }.resume()
    }
    
    func getPersonneByEmail(email : String, completionHandler: @escaping ([User]) -> ()) {
        guard let url = URL(string: urlPersonnes+"email/"+email) else { return }
            URLSession.shared.dataTask(with: url){(data, _, _) in
              guard let data = data else { return }
              let res = try! JSONDecoder().decode(User.self, from: data)
              DispatchQueue.main.async{
                self.currentUser = [res]
                completionHandler([res])
              }
            }.resume()
    }
    
    func authentification(email : String, password : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string: "https://whispering-river-73122.herokuapp.com/api/auth/") else { return }
        
        let user:[String: Any] = [
            "email" : email,
            "password" : password,
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: user)
        
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
    
    
    func addUser(user: UserWithoutId, completionHandler: @escaping (Bool) -> ()) {
           
           guard let url = URL(string: urlPersonnes) else { return }
           
           let newUser:[String: Any] = [
               "email" : user.email,
               "password" : user.password,
               "pseudo" : user.pseudo
           ]
           
           let body = try! JSONSerialization.data(withJSONObject: newUser)
           
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

    
    func editPseudo(id : String, pseudo : String, mdp : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string: urlPersonnes+id) else { return }
        
        let newPseudo:[String: Any] = [
            "newPseudo" : pseudo,
            "password" : mdp
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: newPseudo)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
    
    
    func editMdp(id : String, ancienMdp : String, mdp : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string: urlPersonnes+"/updatepsw/"+id) else { return }
        
        let newMdp:[String: Any] = [
            "password" : ancienMdp,
            "newPassword" : mdp
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: newMdp)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
    
    
    func deletePersonne(id : String){
         guard let url = URL(string: urlPersonnes+id) else { return }
         
         var request = URLRequest(url: url)
         request.httpMethod = "DELETE"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
         URLSession.shared.dataTask(with: request) {
            (data, response, error) in
         }.resume()
    }
}
