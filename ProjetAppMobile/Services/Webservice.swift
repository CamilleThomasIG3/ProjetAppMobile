//
//  Webservice.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/25/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation

public class Webservice : ObservableObject {
    
    @Published var posts = [Post]()
    
    init(){
        getAllPosts()
    }
    
    func getAllPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
            else{
                fatalError("URL is not correct")
        }
        
        URLSession.shared.dataTask(with: url){ data, _, _ in
            
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                self.posts = posts
            }
            
        }.resume()
    }
}
