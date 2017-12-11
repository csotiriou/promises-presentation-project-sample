//
//  PromisesViewController.swift
//  promises_sample
//
//  Created by Christos Sotiriou on 08/12/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit
import PromiseKit

class PromisesViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func getCategories() -> Void {
		self.showProgressHUD()
		HTTPClient.shared.getCategories().then { (categories) -> Void in
			self.showDialogWithOK("Categories downloaded: \(categories.count)")
		}.always {
			self.hideProgressHUD()
		}.catch { (error) in
			self.showDialogWithOK("Error", subtitle: "error: \(error.localizedDescription)")
		}
	}
	
	@IBAction func getArticles() -> Void {
		self.showProgressHUD()
		HTTPClient.shared.getArticles().then { (articles) -> Void in
			self.showDialogWithOK("articles gotten: \(articles.count)")
			}.always {
				self.hideProgressHUD()
			}.catch { (error) in
				print("error")
		}
	}
	
	@IBAction func catchError() -> Void {
		self.showProgressHUD()
		HTTPClient.shared.makeErroneousRequest().then { (articles) -> Void in
			self.showDialogWithOK("Articles Downloaded: \(articles.count)")
		}.always {
			self.hideProgressHUD()
		}.catch { (error) in
			self.showDialogWithOK("Error", subtitle: "error: \(error.localizedDescription)")
		}
	}
	
	
	@IBAction func getArticlesFromFirstcategory() {
		/*
		Gets all the categories from the server, then requests all articles
		that belong into the first category from the server.
		*/
		self.showProgressHUD()
		HTTPClient.shared.getCategories().then { (categories) -> Promise<[Article]> in
			//chaining promises means returing next promise to continue
			//the chain
			return HTTPClient.shared.getArticles(fromCategoryId: categories[0].id)
		}.then { (articles) -> Void in
			self.showDialogWithOK("articles from first category: \(articles.count)")
		}.always {
			self.hideProgressHUD()
		}.catch { (error) in
			self.showDialogWithOK("Error", subtitle: error.localizedDescription)
		}
	}
	
	@IBAction func getAllArticlesFromAllCategories() -> Void {
		/*
		Gets all categories from the server, then for each category it makes a
		call to the server and returns its articles. The request for the categories is run serially,
		and the requests for all categories are run in parallel
		*/
		self.showProgressHUD()
		HTTPClient.shared.getCategories().then { (categories) -> Promise<[[Article]]> in
			//create a promise from each category, which will return its articles.
			let allArticlesPromises = categories.map({ (category) -> Promise<[Article]> in
				return HTTPClient.shared.getArticles(fromCategoryId: category.id)
			})
			//run them in parallel!
			return when(fulfilled: allArticlesPromises)
			}.then { (arrayOfArticleArrays) -> Void in
				
			//simple data processing in order to flatten the array of arrays
			let flattenedArray = arrayOfArticleArrays.reduce([Article](), { (total, currentArray) -> [Article] in
				var result = total
				result.append(contentsOf: currentArray)
				return result
			})
			self.showDialogWithOK("gotten: \(flattenedArray.count) articles")
		}.always {
			self.hideProgressHUD()
		}.catch { (error) in
			print("error: \(error)")
		}
	}
}
