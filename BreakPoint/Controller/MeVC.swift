//
//  MeVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

	// outlets
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		email.text = Auth.auth().currentUser?.email
	}
	
	// target actions
	@IBAction func signout(_ sender: UIButton) {
		let logoutPopup = UIAlertController(title: "Log out", message: "Are you sure?", preferredStyle: .actionSheet)
		logoutPopup.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
			do {
				try Auth.auth().signOut()
				let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
				self.present(authVC, animated: true, completion: nil)
				
			} catch let error { print(error.localizedDescription) }
		}))
		logoutPopup.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
		present(logoutPopup, animated: true, completion: nil)
	}
}
