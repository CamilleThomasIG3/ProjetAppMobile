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
            "content" : r.content,
            "pseudo" : r.user,
            "categoryResponse" : r.categoryResponse
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: newReponse)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            _ = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
        }.resume()
    }
    
    func deleteAllReponse(idRemarque : String) {
        guard let url = URL(string: urlRemarques+idRemarque+"/answers") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func deleteReponseById(idRep : String, idRemarque : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/answers/"+idRep) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            _ = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
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
    
    //LIKE
    func addLike(rep : Reponse, idRemarque : String, user : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string : urlRemarques+idRemarque+"/answers/"+rep._id) else { return }
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
    
    
    func deleteLike(idRep : String, idRemarque : String, pseudo : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/answers/"+idRep+"/likes/"+pseudo) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            _ = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
        }.resume()
    }
    
    //SIGNAL
    func addSignal(rep : Reponse, idRemarque : String, user : String, completionHandler: @escaping (Bool) -> ()) {
        guard let url = URL(string : urlRemarques+idRemarque+"/answers/"+rep._id+"/signals") else { return }
        
        let newSignal : [String: Any] = [
            "pseudo": user
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
    
    
    func deleteSignal(idRep : String, idRemarque : String, pseudo : String){
        guard let url = URL(string: urlRemarques+idRemarque+"/answers/"+idRep+"/signals/"+pseudo) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            _ = try! JSONDecoder().decode(ServerMessage.self, from: data)
            
        }.resume()
    }
    
}

