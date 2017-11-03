//
//  CreateGroupVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 02/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

	// outlets
	@IBOutlet weak var titleField: InsetTextField!
	@IBOutlet weak var descriptionField: InsetTextField!
	@IBOutlet weak var emailSearchField: InsetTextField! {
		didSet {
			emailSearchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		}
	}
	@IBOutlet weak var groupMemberLabel: UILabel!
	@IBOutlet weak var doneButton: UIButton!
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.dataSource = self
			tableView.delegate = self
		}
	}
	
	// variables
	var emails = [String]()
	
	// selector actions
	@objc func textFieldDidChange() {
		guard let searchQuery = emailSearchField.text else { return }
		if searchQuery == "" {
			emails = []
			tableView.reloadData()
		} else {
			DataService.instance.getEmail(forSearchQuery: searchQuery, completion: { (fetchedEmails) in
				self.emails = fetchedEmails
				DispatchQueue.main.async { self.tableView.reloadData() }
			})
		}
	}
	
	// target actions
	@IBAction func done(_ sender: UIButton) { }
	
	@IBAction func cancel(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}

extension CreateGroupVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emails.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
		let profileImage = UIImage(named: "defaultProfileImage")!
		cell.configure(profileImage: profileImage, email: emails[indexPath.row], isSelected: true)
		return cell
	}
}
