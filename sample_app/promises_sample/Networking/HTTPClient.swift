//
//  HTTPClient.swift
//  promises_sample
//
//  Created by Christos Sotiriou on 08/12/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire

class HTTPClient {
	enum Exception : Error {
		case networkingError(Error)
		case parsingError(Error?)
	}
	
	//singleton. In case we need to hold some state variables in here.
	static let shared = HTTPClient()
	
    /// Callback based API, to be used as a generic function for all requests to the API.
    ///
    /// - Parameters:
    ///   - route: The HTTP Route to call
    ///   - parameters: optional parameters to pass to the HTTP call
    ///   - completion: the completion block. The type of the parameters in the completion block determine the parsing
    ///     type that JSONDecoder will use.
	func callbackAPIRequest<T : Decodable>(route : Router, parameters : [String : Any]? = nil, completion : @escaping (T?, Error?) -> Void) {
		request(route.urlString, parameters : parameters).validate().responseData { (dataResponse) in
			if let error = dataResponse.error {
				completion(nil, error)
				return
			}
			if let data = dataResponse.result.value {
				do {
					let decodedObject = try JSONDecoder().decode(T.self, from: data)
					completion(decodedObject, nil)
				} catch {
					completion(nil, error)
				}
			} else {
				completion(nil, Exception.parsingError(nil))
				
			}
		}
	}
	
    
    /// Wrapper on top of the callback based API.
    ///
    /// - Parameters:
    ///   - route: the HTTP Route to make a call to
    ///   - parameters: optional parameters
    /// - Returns: A promise, holding the parsed object as a result. The type of the returned value determines
    ///     the type that JSONDecoder will use to parse the server data.
	func apiRequest<T : Decodable>(route : Router, parameters : [String : Any]? = nil) -> Promise<T> {
		//call the constructor
		return Promise.init(resolvers: { (fulfill, reject) in
			//call the callback-based API, determine the success and failure conditions
			//and call the fulfill or reject handlers appropriately
			self.callbackAPIRequest(route: route, parameters : parameters, completion: { (decodedObject : T?, error : Error?) in
				if let err = error {
					reject(err)
				} else {
					fulfill(decodedObject!)
				}
			})
		})
	}
}

extension HTTPClient {
	func getArticles() -> Promise<[Article]> {
		return self.apiRequest(route: .articles)
	}
	
	func getCategories() -> Promise<[Category]> {
		return self.apiRequest(route: .categories)
	}
	
	func getArticles(fromCategoryId id : Int) -> Promise<[Article]> {
		return self.apiRequest(route: .articles, parameters: ["category" : id])
	}
	
	func makeErroneousRequest() -> Promise<[Article]> {
		return self.apiRequest(route: .error)
	}
}
