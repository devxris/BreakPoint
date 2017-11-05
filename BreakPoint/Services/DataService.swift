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

struct DBPathKeys {
	static let provider = "provider"
	static let email = "email"
	static let users = "users"
	static let groups = "groups"
	static let feed = "feed"
	static let content = "content"
	static let senderId = "senderId"
	static let title = "title"
	static let description = "description"
	static let members = "memebers"
}

class DataService {
	
	static let instance = DataService()
	
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
			REF_FEED.childByAutoId().updateChildValues([DBPathKeys.content: message, DBPathKeys.senderId: uid])
			completion(true)
		}
	}
	
	func getAllFeeds(compeletion: @escaping (_ message: [Message]) -> Void) {
		var messages = [Message]()
		REF_FEED.observeSingleEvent(of: .value) { (feedMessages) in
			guard let feedMessages = feedMessages.children.allObjects as? [DataSnapshot] else { return }
			feedMessages.forEach {
				let content = $0.childSnapshot(forPath: DBPathKeys.content).value as! String
				let senderId = $0.childSnapshot(forPath: DBPathKeys.senderId).value as! String
				let message = Message(content: content, senderId: senderId)
				messages.append(message)
			}
			compeletion(messages)
		}
	}
	
	func gerUsername(from uid: String, completion: @escaping (_ username: String) -> Void) {
		REF_USERS.observeSingleEvent(of: .value) { (users) in
			guard let users = users.children.allObjects as? [DataSnapshot] else { return }
			users.forEach {
				if $0.key == uid { completion($0.childSnapshot(forPath: DBPathKeys.email).value as! String) }
			}
		}
	}
	
	func getEmails(forSearchQuery query: String, completion: @escaping (_ emails: [String]) -> Void) {
		var emails = [String]()
		REF_USERS.observe(.value) { (users) in
			guard let users = users.children.allObjects as? [DataSnapshot] else { return }
			users.forEach {
				let email = $0.childSnapshot(forPath: DBPathKeys.email).value as! String
				if email.contains(query) && email != Auth.auth().currentUser?.email {
					emails.append(email)
				}
			}
			completion(emails)
		}
	}
	
	func getIds(from usernames: [String], completion: @escaping (_ uids: [String]) -> Void) {
		REF_USERS.observeSingleEvent(of: .value) { (users) in
			guard let users = users.children.allObjects as? [DataSnapshot] else { return }
			var uids = [String]()
			users.forEach {
				let email = $0.childSnapshot(forPath: DBPathKeys.email).value as! String
				if usernames.contains(email) {
					uids.append($0.key)
				}
			}
			completion(uids)
		}
	}
	
	func createGroup(with title: String, and description: String, for userIds: [String], completion: @escaping (_ groupCreated: Bool) -> (Void)) {
		REF_GROUPS.childByAutoId().updateChildValues([DBPathKeys.title: title,
													  DBPathKeys.description: description,
													  DBPathKeys.members: userIds])
		{ (error, reference) in
			if error != nil {
				completion(false); print("error on creating group...")
			} else {
				completion(true)
			}
		}
	}
}
