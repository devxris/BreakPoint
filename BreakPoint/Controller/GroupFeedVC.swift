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
	
	// variables
	var group: Group?
	
	func initData(with group: Group) {
		self.group = group
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		groupTitle.text = group?.title
		DataService.instance.getEmails(for: group!, completion: { (fetchedEmails) in
			DispatchQueue.main.async { self.membersLabel.text = fetchedEmails.joined(separator: ",\n") }
		})
		
	}
	
	// target actions
	@IBAction func send(_ sender: UIButton) {
	}
	
	@IBAction func back(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}
