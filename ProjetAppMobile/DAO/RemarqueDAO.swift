//
//  RemarqueDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class RemarqueDAO : ObservableObject{
    
    let rootURL : String = "https://whispering-river-73122.herokuapp.com/api/remarks/"
    
    //NON VERIFIER !
    func getRemaquesByDate(order : Int, skip : Int, number : Int) -> [Remarque] {
        // Prepare URL
        let preString = "sorted/date"
        let postString = "?order="+String(order)+"&skip="+String(skip)+"&number="+String(number)
        let url = URL(string: rootURL+preString+postString)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)
         
        // Perform HTTP Request
        var res : [Remarque] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
            
                // Convert HTTP Response Data to a String
                if let data = data{
                    
                    do{
                        res = try JSONDecoder().decode([Remarque].self, from: data)
                        
                    }catch let error {
                        print(error)
                    }
                }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return res
    }
    
    
    func getRemarqueById(id : String) -> Remarque? {
        let postString = String(id)
        let url = URL(string: rootURL+postString)
        guard let requestURL = url else {fatalError()}
        
        //Prepare URL request object
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
        
        //Perform HTTP Request
        var res : Remarque? = nil
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            //check for error
            if let error = error{
                print("Error took place \(error)")
                return
            }
            
            //convert HTTP response data to String
            if let data = data{
                do{
                    res = try JSONDecoder().decode(Remarque.self, from: data)
                }catch let error{
                    print(error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return res
    }
    
    //NON VERIFIER !
    func getRemarquesOfPersonne(idPersonne : String) -> [Remarque] {
        // Prepare URL
        let preString = "findByUserId"
        let postString = "?id="+String(idPersonne)
        let url = URL(string: rootURL+preString+postString)
        guard let requestUrl = url else { fatalError() }
        //Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value :0)

        // Perform HTTP Request
        var res : [Remarque] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
            
                // Convert HTTP Response Data to a String
                if let data = data{
                    
                    do{
                        res = try JSONDecoder().decode([Remarque].self, from: data)
                        
                    }catch let error {
                        print(error)
                    }
                }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return res
    }
    
    //A VERIFIER
    func deleteRemarque(id : String)-> Bool{
        // Prepare URL
        let url = URL(string: rootURL+"delete")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "id="+id;
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        var res : Bool = false
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                    let resp = response as? HTTPURLResponse
                    res = (resp?.statusCode == 200)
                
        }
        task.resume()
        
        return res
    }
    
    //A FAIRE
//    func addRemarque(r : Remarque)->Bool {}
//    func getRemarquesOfCategorie(idCategorie : String) -> [Remarque] {}
    
    
    //JE PENSE SERT A RIEN CAR UTILISE MODELS !!!!
//    func getPersonne(id :String) -> String {}
//    func getContenu(id : String) -> String {}
//    func getDate(id : String) -> String {}
//    func getCategorie(id : String) -> String {}
//    
//    func setDate(id : String) {}
//    func setPersonne(id : String, idPersonne : String) {}
//    func setContenu(id : String, contenu : String) {}
//    func setCategorie(id : String, categorie : String ) {}
}
