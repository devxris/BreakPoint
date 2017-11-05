//
//  GroupFeedCell.swift
//  BreakPoint
//
//  Created by Chris Huang on 05/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var messageContent: UILabel!
	
	func configure(image: UIImage, email: String, message: String) {
		self.profileImage.image = image
		self.email.text = email
		self.messageContent.text = message
	}
}
