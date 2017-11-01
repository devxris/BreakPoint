//
//  FeedCell.swift
//  BreakPoint
//
//  Created by Chris Huang on 01/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var messgeContent: UILabel!
	
	func configure(profileImage: UIImage, email: String, messageContent: String) {
		self.profileImage.image = profileImage
		self.email.text = email
		self.messgeContent.text = messageContent
	}
}
