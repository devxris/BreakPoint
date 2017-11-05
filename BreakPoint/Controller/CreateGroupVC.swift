//
//  CreateGroupVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 02/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import Firebase

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
	var chosenUsers = [String]()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		doneButton.isHidden = false
	}
	
	// selector actions
	@objc func textFieldDidChange() {
		guard let searchQuery = emailSearchField.text else { return }
		if searchQuery == "" {
			emails = []
			tableView.reloadData()
		} else {
			DataService.instance.getEmails(forSearchQuery: searchQuery, completion: { (fetchedEmails) in
				self.emails = fetchedEmails
				DispatchQueue.main.async { self.tableView.reloadData() }
			})
		}
	}
	
	// target actions
	@IBAction func done(_ sender: UIButton) {
		guard let title = titleField.text, title != "" else { return }
		guard let desc = descriptionField.text, desc != "" else { return }
		guard let currentUserId = Auth.auth().currentUser?.uid else { return }
		DataService.instance.getIds(from: chosenUsers) { (fetechedIds) in
			// add current user to fetchedIds
			var userIds = fetechedIds
			userIds.append(currentUserId)
			// create group
			DataService.instance.createGroup(with: title, and: desc, for: userIds) { (groupCreated) in
				if groupCreated {
					self.dismiss(animated: true, completion: nil)
				} else {
					print("Group is not created...")
				}
			}
		}
	}
	
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
		let isSelected = chosenUsers.contains(emails[indexPath.row])
		cell.configure(profileImage: profileImage, email: emails[indexPath.row], isSelected: isSelected)
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		// need to get info from real cell rather than dequeueCell which is just a temporary one
		guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
		guard let chosenUser = cell.email.text else { return }
		if !chosenUsers.contains(chosenUser) {
			chosenUsers.append(chosenUser)
			groupMemberLabel.text = chosenUsers.joined(separator: "\n")
			doneButton.isHidden = false
		} else {
			chosenUsers = chosenUsers.filter { $0 != chosenUser }
			if chosenUsers.count >= 1 {
				groupMemberLabel.text = chosenUsers.joined(separator: "\n")
			} else {
				groupMemberLabel.text = "invite people"
				doneButton.isHidden = true
			}
		}
	}
}
