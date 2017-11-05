//
//  GroupsVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 30/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

	// outlets
	@IBOutlet weak var groupTable: UITableView! {
		didSet {
			groupTable.dataSource = self
			groupTable.delegate = self
			groupTable.rowHeight = UITableViewAutomaticDimension
			groupTable.estimatedRowHeight = 100
		}
	}
	
	// variables
	var groups = [Group]()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
			DataService.instance.getAllGroups { (fetchedGroups) in
				self.groups = fetchedGroups
				DispatchQueue.main.async { self.groupTable.reloadData() }
			}
		}
	}
}

extension GroupsVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupCell
		let group = groups[indexPath.row]
		cell.configure(title: group.title, description: group.description, membersCount: group.memberCount)
		return cell
	}
}
