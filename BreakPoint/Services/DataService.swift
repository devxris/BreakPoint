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
	
	// variables
	private var _REF_BASE = DB_BASE
	private var _REF_USERS = DB_BASE.child("users")
	private var _REF_GROUPS = DB_BASE.child("groups")
	private var _REF_FEED = DB_BASE.child("feed")
	
	var REF_BASE: DatabaseReference { return _REF_BASE }
	var REF_USERS: DatabaseReference { return _REF_USERS }
	var REF_GROUPS: DatabaseReference { return _REF_GROUPS }
	var REF_FEED: DatabaseReference { return _REF_FEED }
	
	func createDBUser(uid: String, userData: [String: Any]) {
		REF_USERS.child(uid).updateChildValues(userData)
	}
}
