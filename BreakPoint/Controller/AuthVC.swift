//
//  AuthVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

	// target actions
	
	@IBAction func signinWithEmail(_ sender: UIButton) {
		guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") else { return }
		present(loginVC, animated: true, completion: nil)
	}
	
	@IBAction func signinWithFacebook(_ sender: UIButton) {
	}
	
	@IBAction func signinWithGooglePlus(_ sender: UIButton) {
	}
}
