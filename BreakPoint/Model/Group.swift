//
//  Group.swift
//  BreakPoint
//
//  Created by Chris Huang on 05/11/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

struct Group {
	
	private var _title: String
	private var _description: String
	private var _key: String
	private var _memberCount: Int
	private var _members: [String]
	
	var title: String { return _title }
	var description: String { return _description }
	var key: String { return _key }
	var memberCount: Int { return _memberCount }
	var members: [String] { return _members }
	
	init(title: String, description: String, key: String, members: [String], memberCount: Int) {
		self._title = title
		self._description = description
		self._key = key
		self._members = members
		self._memberCount = memberCount
	}
}
