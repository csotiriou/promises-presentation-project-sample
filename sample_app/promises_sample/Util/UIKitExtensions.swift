//
//  Util.swift
//  promises_sample
//
//  Created by Christos Sotiriou on 08/12/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
	@discardableResult
	func showDialogWithOK(_ title : String?, subtitle : String? = nil, completionBlock: @escaping () -> Void = { }) -> UIAlertController {
			let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertControllerStyle.alert)
			alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
					completionBlock()
			}))
			self.present(alertController, animated: true, completion: nil)
			return alertController
	}
	
	func showProgressHUD() -> Void {
			SVProgressHUD.show()
	}
	
	func hideProgressHUD() -> Void {
		SVProgressHUD.dismiss()
	}
}
