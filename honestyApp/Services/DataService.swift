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
	private var _REF_MESSAGES = DB_BASE.child("messages")
	
	var REF_BASE: DatabaseReference {
		return _REF_BASE
	}
	var REF_USERS: DatabaseReference {
		return _REF_USERS
	}
	var REF_MESSAGES: DatabaseReference {
		return _REF_MESSAGES
	}
	func createDBUser(uid: String, userData: Dictionary<String,Any>){
		REF_USERS.child(uid).updateChildValues(userData)
	}
	func sendMessage(uid: String, messageData: Dictionary<String,Any>, completion: @escaping (_ isSuccess: Bool,_ error: Error?) -> ()){
		REF_MESSAGES.child(uid).childByAutoId().updateChildValues(messageData) { (error, ref) in
			if error != nil {
				completion(false, error)
			}else {
				completion(true, nil)
			}
			
		}
	}
	func fetchUserWithUID(uid: String, completion: @escaping (_ snapshot: DataSnapshot? ,_ isSuccess: Bool, _ error: Error?) -> ()){
		REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
			
			completion(snapshot, true, nil)
		}) { (err) in
			completion(nil, false, err)
		}
	}
	func getMessagesWithUID(uid: String, completion: @escaping (_ snapshot: DataSnapshot?, _ isSuccess: Bool, _ error: Error?)->()){
		REF_MESSAGES.child(uid).observe(.value, with: { (snapshot) in
			completion(snapshot, true, nil)
		}) { (err) in
			completion(nil, false, err)
		}
	}
}


