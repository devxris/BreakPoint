//
//  AuthService.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
	
	static let instance = AuthService()
	typealias CompletionHandler = (_ status: Bool, _ error: Error?) -> Void
	
	func registerUser(with email: String, and password: String, completion: @escaping CompletionHandler) {
		Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
			
			guard let user = user else { completion(false, error); return }
			let userData: [String: Any] = [DBPathKeys.provider: user.providerID,
			                               DBPathKeys.email: user.email as Any]
			DataService.instance.createDBUser(uid: user.uid, userData: userData)
		}
	}
	
	func loginUser(with email: String, and password: String, completion: @escaping CompletionHandler) {
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			guard let _ = user else { completion(false, error); return }
			completion(true, nil)
		}
	}
}
