//
//  RemarqueDAO.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/28/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

class RemarqueDAO : ObservableObject{
    init() {
        
    }
    
    func getRemarque(id : String) -> Remarque? {
        let preString = "https://whispering-river-73122.herokuapp.com/api/remarks"
        let postString = "/"+String(id)
        let url = URL(string: preString+postString)
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
        print(res)
        return res
    }
//    func getPersonne(id :String) -> String {}
//    func getContenu(id : String) -> String {}
//    func getDate(id : String) -> String {}
//    func getCategorie(id : String) -> String {}
//    
//    func setDate(id : String) {}
//    func setPersonne(id : String, idPersonne : String) {}
//    func setContenu(id : String, contenu : String) {}
//    func setCategorie(id : String, categorie : String ) {}
//    
//    func addRemarque(r : Remarque) {}
//    func deleteRemarque(id : String) {}
//    func getAllRemarques() -> [Remarque] {}
//    func getRemarquesWithPersonne(idPersonne : String) -> [Remarque] {}
//    func getRemarquesWithCat(idCategorie : String) -> [Remarque] {}
//    func getRemarquesByDate(date : String) -> [Remarque] {}
//    //fonctions pour tri par rapport à la date
//    func count() -> Int {}
}
