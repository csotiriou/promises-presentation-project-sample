//
//  Router.swift
//  promises_sample
//
//  Created by Christos Sotiriou on 08/12/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit

enum Router {
    case articles
    case categories
    case error
    
	var urlString : String {
        let rootUrl = "http://localhost:3000"
        
        let path : String = {
            switch self {
            case .articles:
                return "/api/articles"
            case .categories:
                return "/api/categories"
            case .error:
                return "/api/error"
            }
        }()
        
        return rootUrl + path
    }
}
