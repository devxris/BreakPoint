//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 05/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
	
	// outlets
	@IBOutlet weak var groupTitle: UILabel!
	@IBOutlet weak var membersLabel: UILabel!
	@IBOutlet weak var groupFeedTable: UITableView! {
		didSet {
			groupFeedTable.dataSource = self
			groupFeedTable.delegate = self
		}
	}
	@IBOutlet weak var messageField: InsetTextField!
	@IBOutlet weak var sendButton: UIButton!
	@IBOutlet weak var messageContainer: UIView! { didSet { messageContainer.bindToKeyboard() } }
	
	// variables
	var group: Group?
	var groupMessages = [Message]()
	
	func initData(with group: Group) {
		self.group = group
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		groupTitle.text = group?.title
		DataService.instance.getEmails(for: group!, completion: { (fetchedEmails) in
			DispatchQueue.main.async { self.membersLabel.text = fetchedEmails.joined(separator: ", \n") }
		})
		
		DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
			DataService.instance.getAllMessages(for: self.group!) { (fetchedGroupMessages) in
				self.groupMessages = fetchedGroupMessages
				DispatchQueue.main.async {
					self.groupFeedTable.reloadData()
					if self.groupMessages.count > 0 {
						let endIndexPath = IndexPath(row: self.groupMessages.count - 1, section: 0)
						self.groupFeedTable.scrollToRow(at: endIndexPath, at: .none, animated: true)
					}
				}
			}
		}
	}
	
	// target actions
	@IBAction func send(_ sender: UIButton) {
		if messageField.text != "" {
			messageField.isEnabled = false
			sendButton.isEnabled = false
			guard let message = messageField.text else { return }
			guard let currentUserID = Auth.auth().currentUser?.uid else { return }
			DataService.instance.uploadPost(with: message, forUID: currentUserID, withGroupKey: group?.key, completion: { (completed) in
				if completed {
					self.messageField.text = ""
					self.messageField.isEnabled = true
					self.sendButton.isEnabled = true
				}
			})
		}
	}
	
	@IBAction func back(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}

extension GroupFeedVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groupMessages.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupFeedCell
		let message = groupMessages[indexPath.row]
		DataService.instance.gerUsername(from: message.senderId) { (email) in
			cell.configure(image: UIImage(named: "defaultProfileImage")!, email: email, message: message.content)
		}
		return cell
	}
}
