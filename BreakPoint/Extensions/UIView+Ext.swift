//
//  UIView+Ext.swift
//  BreakPoint
//
//  Created by Chris Huang on 01/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

extension UIView {
	
	func bindToKeyboard() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
	}
	
	@objc func keyboardWillChange(notification: Notification) {
		let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
		let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
		let beginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
		let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		let deltaY = endFrame.origin.y - beginFrame.origin.y
		
		UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions.init(rawValue: curve), animations: {
			self.frame.origin.y += deltaY
		}, completion: nil)
	}
}
