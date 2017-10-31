//
//  LoginVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

	// outlets
	@IBOutlet weak var email: InsetTextField! { didSet { email.delegate = self} }
	@IBOutlet weak var password: InsetTextField! { didSet { password.delegate = self} }
	
	// target actions
	@IBAction func signin(_ sender: UIButton) {
		guard let email = email.text, let password = password.text else { return }
		// if user registed, login, else register a new user
		AuthService.instance.loginUser(with: email, and: password) { (success, error) in
			if success {
				self.dismiss(animated: true, completion: nil)
			} else {
				print(error?.localizedDescription ?? "Unknown login error")
			}
			
			AuthService.instance.registerUser(with: email, and: password, completion: { (success, error) in
				if success {
					print("\(email) registerd successfully...")
					AuthService.instance.loginUser(with: email, and: password, completion: { (success, _) in
						if success {
							print("logging in...")
							self.dismiss(animated: true, completion: nil)
						}
					})
				} else {
					print(error?.localizedDescription ?? "Unknown register error")
				}
			})
		}
	}
	
	@IBAction func cancel(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}

extension LoginVC: UITextFieldDelegate {
	
}
