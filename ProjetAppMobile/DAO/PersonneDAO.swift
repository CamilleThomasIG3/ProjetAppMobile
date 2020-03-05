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
    let token : String
    let user : [String:String]
    //voir avec Mathis mettre en format comme Matt
}

class PersonneDAO: ObservableObject{
    @Published var personnes = [User]()
    @Published var currentUser = [User]()
    
    init() {
        getAllPersonnes()
    }
    
    func getAllPersonnes() {
        guard let url = URL(string: "https://whispering-river-73122.herokuapp.com/api/users") else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([User].self, from: data)
          DispatchQueue.main.async{
            print(res)
            self.personnes = res
          }
        }.resume()
    }
    
    func getPersonneById(id : String, completionHandler: @escaping ([User]) -> ()) {
        guard let url = URL(string: "https://whispering-river-73122.herokuapp.com/api/users/"+id) else { return }
            URLSession.shared.dataTask(with: url){(data, _, _) in
              guard let data = data else { return }
              let res = try! JSONDecoder().decode(User.self, from: data)
              DispatchQueue.main.async{
                print(res)
                self.currentUser = [res]
                completionHandler([res])
                print(res.pseudo)
              }
            }.resume()
    }
    
    
    func addUser(user: UserWithoutId, completionHandler: @escaping (Bool) -> ()) {
           
           guard let url = URL(string: "https://whispering-river-73122.herokuapp.com/api/users") else { return }
           
           let newUser:[String: Any] = [
               "email" : user.email,
               "password" : user.password,
               "pseudo" : user.pseudo,
               "register_date" : user.register_date
           ]
           
           let body = try! JSONSerialization.data(withJSONObject: newUser)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.httpBody = body
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in

               guard let data = data else { return }
               
               let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)

               print(resData.token)

            if resData.user.count != 0 {
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

    
//    func deletePersonne(id : String) {}
}
