//
//  AuthService.swift
//  sarahahClone
//
//  Created by Alper Tabak on 19.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
	static let instance = AuthService()
	
	
	func registerUser(withEmail email:String,andUsername username: String, andPassword password:String, completion: @escaping (_ isSuccess: Bool, _ error: Error?) -> () ){
		Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
			guard let user = user else {
				completion(false, err)
				return
			}
			let userData = ["email":user.email,"username": username]
			DB.instance.createDBUser(uid: user.uid, userData: userData)
			completion(true, nil)
		}
		
	}
	
	func loginUser(withEmail email: String, andPassword password: String, completion: @escaping (_ isSuccess: Bool, _ error: Error?) -> () ){
		Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
			if err != nil {
				completion(false, err)
				return
			}
			completion(true, nil)
		}
	}
	
}

