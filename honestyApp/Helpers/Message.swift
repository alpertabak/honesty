//
//  Message.swift
//  honestyApp
//
//  Created by Alper Tabak on 21.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit

struct Message {
	let userID: String
	let message: String
	init( dictionary: [String:Any]){
		self.userID = dictionary["senderID"] as? String ?? ""
		self.message = dictionary["text"] as? String ?? ""
	}
}
