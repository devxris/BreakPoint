//
//  CreatePostVC.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

	// outlets
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var textView: UITextView! { didSet { textView.delegate = self} }
	@IBOutlet weak var sendButton: UIButton! { didSet { sendButton.bindToKeyboard()} }
	
	// target actions
	@IBAction func send(_ sender: UIButton) {
		guard let message = textView.text, message != "start posting here..." else { return }
		guard let currentUser = Auth.auth().currentUser else { return }
		sendButton.isEnabled = false
		DataService.instance.uploadPost(with: message, forUID: currentUser.uid, withGroupKey: nil) { (success) in
			if success {
				print("message is posting...")
				self.sendButton.isEnabled = true
				self.dismiss(animated: true, completion: nil)
			} else {
				self.sendButton.isEnabled = true
				print("message lost...")
			}
		}
	}
	
	@IBAction func cancel(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}

extension CreatePostVC: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView) { textView.text = "" }
}
