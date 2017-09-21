//
//  MainController.swift
//  honestyApp
//
//  Created by Alper Tabak on 20.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class UserProfileController: UIViewController, UITextViewDelegate {
	
	var userId: String?
	
	let userProfileHeader: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let headerBottomBorder: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
		return view
	}()
	let userProfileImageView: UIImageView = {
		let image = #imageLiteral(resourceName: "noUserPic")
		let imageView = UIImageView()
		imageView.image = image
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = Colors.projectBlue
		imageView.layer.cornerRadius = 40
		imageView.clipsToBounds = true
		return imageView
	}()
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.text = "heisenberx"
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.textColor = .black
		return label
	}()
	lazy var messageTextView: UITextView = {
		let tv = UITextView()
		tv.layer.borderWidth = 1
		tv.layer.borderColor = UIColor.black.cgColor
		tv.text = "Share your thoughts"
		tv.delegate = self
		return tv
	}()
	let sendButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Send Message", titleColor: .white, fontType: "bold", fontSize: 25, background: UIColor.rgb(red: 149, green: 204, blue: 244), cornerRadius: 25)
		button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
		return button
	}()
	let logoutButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Logout", titleColor: Colors.projectBlue, fontType: "bold", fontSize: 18, background: nil, cornerRadius: nil)
		button.addTarget(self, action: #selector(UserProfileController.logoutHandle), for: .touchUpInside)
		return button
	}()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "User Profile"
		view.addSubview(logoutButton)
		view.addSubview(userProfileHeader)
		userProfileHeader.addSubview(headerBottomBorder)
		userProfileHeader.addSubview(userProfileImageView)
		userProfileHeader.addSubview(usernameLabel)
		view.addSubview(messageTextView)
		view.addSubview(sendButton)
		sendButton.isEnabled = false
		userProfileHeader.addSubview(logoutButton)
		setupUI()
		if userId == Auth.auth().currentUser?.uid || userId == nil   {
			logoutButton.anchor(top: userProfileHeader.topAnchor, left: nil, bottom: nil, right: userProfileHeader.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, height: 0, width: 0)
		}
		fetchUser()
	}
	
	
	fileprivate func setupUI(){
		
		userProfileHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 160, width: 0)
		headerBottomBorder.anchor(top: nil, left: userProfileHeader.leftAnchor, bottom: userProfileHeader.bottomAnchor, right: userProfileHeader.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 1, width: 0)
		userProfileImageView.setSizes(width: 80, height: 80)
		userProfileImageView.anchorCenter(x: userProfileHeader.centerXAnchor, xCons: 0, y: userProfileHeader.centerYAnchor, yCons: 0)
		usernameLabel.anchor(top: userProfileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
		usernameLabel.anchorCenter(x: userProfileHeader.centerXAnchor, xCons: 0, y: nil, yCons: 0)
		messageTextView.anchor(top: userProfileHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, height: 200, width: 0)
		sendButton.anchor(top: messageTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 15, paddingBottom: 0, paddingRight: 16, height: 50, width: 0)
		
	}
	func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		messageTextView.resignFirstResponder()
		return true
	}
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text == "Share your thoughts" {
			textView.text = ""
		}
	}
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text == "Share your thoughts" || textView.text.characters.count < 16 {
			sendButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
			sendButton.isEnabled = false
		}else {
			sendButton.isEnabled = true
			sendButton.backgroundColor = Colors.projectBlue
		}
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	@objc func sendMessage(){
		guard let message = messageTextView.text, message.characters.count > 16 else {return}
		guard let currentUser = Auth.auth().currentUser?.uid else {return}
		guard let uid = self.user?.uid else {return}
		let messageData = ["senderID": currentUser, "text": message]
		DB.instance.sendMessage(uid: uid, messageData: messageData) { (success, err) in
			if success {
				self.messageTextView.text = ""
				self.sendButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
				self.sendButton.isEnabled = false
			}else {
				print(err?.localizedDescription ?? "")
			}
		}
	}
	var user: User?
	fileprivate func fetchUser(){
		let uid = userId ?? Auth.auth().currentUser?.uid ?? ""
		
		/*Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
			print(snapshot.value ?? "")
			
			guard let dictionary = snapshot.value as? [String:Any] else {return}
			self.user = User(uid: uid,dictionary: dictionary)
			self.usernameLabel.text = self.user?.username
			
		}) { (err) in
			print("Üye çekme işlemi başarısız oldu:",err)
		}*/
		
		DB.instance.fetchUserWithUID(uid: uid) { (snapshot, success, err) in
			if success {
				guard let dict = snapshot?.value as? [String:Any] else {return}
				self.user = User(uid: uid, dictionary: dict)
				self.usernameLabel.text = self.user?.username
			}else {
				print(err?.localizedDescription ?? "")
			}
		}
	}
	@objc func logoutHandle(){
		do{
			try Auth.auth().signOut()
			let loginVC = UINavigationController(rootViewController: LoginController())
			self.present(loginVC, animated: true, completion: nil)
			return
		}catch{
			print("Something went wrong")
		}
	}
}

