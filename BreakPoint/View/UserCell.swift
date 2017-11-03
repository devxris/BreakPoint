//
//  UserCell.swift
//  BreakPoint
//
//  Created by Chris Huang on 02/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
	
	// outlets
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var checkMark: UIImageView!
	
	// variables
	var isShowing = false

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		if selected {
			if isShowing {
				checkMark.isHidden = true
				isShowing = false
			} else {
				checkMark.isHidden = false
				isShowing = true
			}
		}
	}
	
	func configure(profileImage image: UIImage, email: String, isSelected: Bool) {
		self.profileImage.image = image
		self.email.text = email
		self.checkMark.isHidden = !isSelected
	}
}
