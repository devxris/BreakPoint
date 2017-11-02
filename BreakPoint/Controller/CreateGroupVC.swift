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
	@IBOutlet weak var tableView: UITableView!
	
	// target actions
	@IBAction func done(_ sender: UIButton) {
	}
	
	
	@IBAction func cancel(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}
