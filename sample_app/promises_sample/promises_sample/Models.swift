//
//  Models.swift
//  promises_sample
//
//  Created by Christos Sotiriou on 08/12/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit

class Article : Codable {
    var summary : String?
    var content : String?
    var title : String?
    
    enum CodingKeys : String, CodingKey {
        case summary = "summary"
        case content = "content"
        case title = "title"
    }
}

class Category : Codable {
    var name : String?
    var id : Int
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case id = "id"
    }
}
