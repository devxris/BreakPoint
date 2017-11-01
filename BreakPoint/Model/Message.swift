//
//  Message.swift
//  BreakPoint
//
//  Created by Chris Huang on 01/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

struct Message {
	
	private var _content: String
	private var _senderId: String
	
	var content: String { return _content }
	var senderId: String { return _senderId }
	
	init(content: String, senderId: String) {
		self._content = content
		self._senderId = senderId
	}
}
