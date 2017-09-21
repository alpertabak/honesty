//
//  Users.swift
//  honestyApp
//
//  Created by Alper Tabak on 21.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit
import UIKit

struct User {
	let username: String
	let uid: String
	init(uid:String,dictionary: [String:Any]) {
		self.uid = uid
		self.username = dictionary["username"] as? String ?? ""
	}
}
