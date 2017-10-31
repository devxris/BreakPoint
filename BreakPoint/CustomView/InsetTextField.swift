//
//  InsetTextField.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

@IBDesignable
class InsetTextField: UITextField {

	private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	func setupView() {
		let placeHolder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
		self.attributedPlaceholder = placeHolder
	}
	
	// override UITextField superclass
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, padding)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, padding)
	}
	
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, padding)
	}
}
