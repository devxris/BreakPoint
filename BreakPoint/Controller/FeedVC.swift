//
//  FeedVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 30/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

	// outlets
	@IBOutlet weak var feedTable: UITableView! {
		didSet {
			feedTable.dataSource = self
			feedTable.delegate = self
			feedTable.estimatedRowHeight = 100
			feedTable.rowHeight = UITableViewAutomaticDimension
		}
	}
	
	// variables
	var messages = [Message]()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		DataService.instance.getAllFeeds { (fetchedMessages) in
			self.messages = fetchedMessages.reversed()
			DispatchQueue.main.async { self.feedTable.reloadData() }
		}
	}
}

extension FeedVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
		let message = messages[indexPath.row]
		let profileImage = UIImage(named: "defaultProfileImage")!
		DataService.instance.gerUsername(from: message.senderId) { (username) in
			cell.configure(profileImage: profileImage, email: username, messageContent: message.content)
		}
		return cell
	}
}
