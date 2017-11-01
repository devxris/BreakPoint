//
//  DataService.swift
//  BreakPoint
//
//  Created by Chris Huang on 31/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference() // Firebase database singleton reference

class DataService {
	
	static let instance = DataService()
	
	private struct DBPathKeys {
		static let users = "users"
		static let groups = "groups"
		static let feed = "feed"
	}
	
	// variables
	private var _REF_BASE = DB_BASE
	private var _REF_USERS = DB_BASE.child(DBPathKeys.users)
	private var _REF_GROUPS = DB_BASE.child(DBPathKeys.groups)
	private var _REF_FEED = DB_BASE.child(DBPathKeys.feed)
	
	var REF_BASE: DatabaseReference { return _REF_BASE }
	var REF_USERS: DatabaseReference { return _REF_USERS }
	var REF_GROUPS: DatabaseReference { return _REF_GROUPS }
	var REF_FEED: DatabaseReference { return _REF_FEED }
	
	func createDBUser(uid: String, userData: [String: Any]) {
		REF_USERS.child(uid).updateChildValues(userData)
	}
	
	func uploadPost(with message: String, forUID uid: String, withGroupKey groupKey: String?, completion: @escaping (_ status: Bool) -> Void) {
		if groupKey != nil {
			// send to group reference
		} else {
			REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
			completion(true)
		}
	}
}
