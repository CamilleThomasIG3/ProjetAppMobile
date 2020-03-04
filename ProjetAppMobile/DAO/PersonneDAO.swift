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
   let res, message: String
}
class PersonneDAO: ObservableObject{
    @Published var personnes = [User]()//problème ici
    @Published var currentUser = [User]()
    
    init() {
        
    }
    
    func getAllPersonnes() {
        guard let url = URL(string: "https://whispering-river-73122.herokuapp.com/api/users") else { return }
        URLSession.shared.dataTask(with: url){(data, _, _) in
          guard let data = data else { return }
          let res = try! JSONDecoder().decode([User].self, from: data)
          DispatchQueue.main.async{
            print(res)
            self.personnes = res
            print("ok")
          }
        }.resume()
    }
    
//    func getPersonneByEmail(email : String, completionHandler: @escaping ([User]) -> ()) {
//        guard let url = URL(string: "https://whispering-river-73122.herokuapp.com/api/users/"+email) else { return }
//            URLSession.shared.dataTask(with: url){(data, _, _) in
//              guard let data = data else { return }
//              let res = try! JSONDecoder().decode([User].self, from: data)
//              DispatchQueue.main.async{
//                print(res)
//                self.currentUser = res
//                completionHandler(res)
//                print(res[0].pseudo)
//              }
//            }.resume()
 //   }
//    func getPersonne(id : String) -> Personne? {}
//    func getEmail(id : String) -> String {}
//    func getPseudo(id : String) -> String {}
//    func getMdP(id : String) -> String {}
//    
//    func setEmail(id : String, email : String) {}
//    func setPseudo(id : String, pseudo : String) -> String {}
//    func setMdp(id : String, mdp : String) -> String {}
//
//    func login(email : String, password : String) -> Personne?
//    func addPersonne(p : Personne) {} //inscription
//    func deletePersonne(id : String) {}
//    func count() -> Int {}
}
