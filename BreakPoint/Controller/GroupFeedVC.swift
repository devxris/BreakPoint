//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 05/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
	
	// outlets
	@IBOutlet weak var groupTitle: UILabel!
	@IBOutlet weak var membersLabel: UILabel!
	@IBOutlet weak var groupFeedTable: UITableView!
	@IBOutlet weak var messageContainer: UIView! { didSet { messageContainer.bindToKeyboard() } }
	@IBOutlet weak var messageField: InsetTextField!
	@IBOutlet weak var sendButton: UIButton!
		
	// target actions
	@IBAction func send(_ sender: UIButton) {
	}
	
	@IBAction func back(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}
