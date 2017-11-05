//
//  GroupCell.swift
//  BreakPoint
//
//  Created by Chris Huang on 05/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

	// outlets
	@IBOutlet weak var groupTitle: UILabel!
	@IBOutlet weak var groupDescription: UILabel!
	@IBOutlet weak var members: UILabel!
	
	func configure(title: String, description: String, membersCount: Int) {
		self.groupTitle.text = title
		self.groupDescription.text = description
		self.members.text = "\(membersCount) memebers"
	}
}
