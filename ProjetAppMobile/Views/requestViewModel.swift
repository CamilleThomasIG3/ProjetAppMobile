//
//  requestViewModel.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/25/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class requestViewModel: ObservableObject {
    init() {
        fetchPosts()
    }
    
    var posts = [Post](){
        didSet{
            didChange.send(self)
        }
    }
    
    private func fetchPosts(){
      //  Webservice().getAllPosts(){
        //    self.posts = $0
       // }
   }
    
    let didChange = PassthroughSubject<requestViewModel, Never>()
}
