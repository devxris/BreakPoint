//
//  GroupsVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 30/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

	@IBOutlet weak var groupTable: UITableView! {
		didSet {
			groupTable.dataSource = self
			groupTable.delegate = self
		}
	}
}

extension GroupsVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupCell
		cell.configure(title: "Groups title", description: "Just fake one", membersCount: 5)
		return cell
	}
}
