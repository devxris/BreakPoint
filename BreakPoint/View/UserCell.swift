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

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	func configure(profileImage image: UIImage, email: String, isSelected: Bool) {
		self.profileImage.image = image
		self.email.text = email
		self.checkMark.isHidden = !isSelected
	}
}
