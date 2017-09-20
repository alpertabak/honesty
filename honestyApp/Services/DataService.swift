//
//  DataService.swift
//  sarahahClone
//
//  Created by Alper Tabak on 19.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = Database.database().reference()
class DB {
	static let instance = DB()
	private var _REF_BASE = DB_BASE
	private var _REF_USERS = DB_BASE.child("users")
	
	var REF_BASE: DatabaseReference {
		return _REF_BASE
	}
	var REF_USERS: DatabaseReference {
		return _REF_USERS
	}
	func createDBUser(uid: String, userData: Dictionary<String,Any>){
		REF_USERS.child(uid).updateChildValues(userData)
	}
}


