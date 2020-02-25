//
//  Post.swift
//  ProjetAppMobile
//
//  Created by user165000 on 2/25/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import Foundation
import SwiftUI

struct Post: Codable, Hashable, Identifiable{
    let id:Int
    let title : String
    let body: String
}
