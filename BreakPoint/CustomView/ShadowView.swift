//
//  ShadowView.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	func setupView() {
		self.layer.cornerRadius = 10
		self.layer.shadowOpacity = 0.75
		self.layer.shadowRadius = 5
		self.layer.shadowColor = UIColor.lightGray.cgColor
		self.layer.shadowOffset = CGSize(width: 2, height: 5)
	}
}
