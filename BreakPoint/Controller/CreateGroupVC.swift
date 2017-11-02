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
	@IBOutlet weak var emailSearchField: InsetTextField!
	@IBOutlet weak var groupMemberLabel: UILabel!
	@IBOutlet weak var doneButton: UIButton!
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.dataSource = self
			tableView.delegate = self
		}
	}
	
	// target actions
	@IBAction func done(_ sender: UIButton) {
	}
	
	
	@IBAction func cancel(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}

extension CreateGroupVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
		let profileImage = UIImage(named: "defaultProfileImage")!
		cell.configure(profileImage: profileImage, email: "1@1.com", isSelected: true)
		return cell
	}
}
