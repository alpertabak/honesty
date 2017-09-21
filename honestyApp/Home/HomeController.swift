//
//  HomeController.swift
//  honestyApp
//
//  Created by Alper Tabak on 21.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class HomeController: UITableViewController {
	var userMessages = [Message]()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Messages"
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(HomeCell.self, forCellReuseIdentifier: "cellId")
		fetchMessages()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	func fetchMessages(){
		guard let uid = Auth.auth().currentUser?.uid else {return}
		DB.instance.getMessagesWithUID(uid: uid) { (snapshot, success, err) in
			if success {
				self.userMessages.removeAll()
				guard let dict = snapshot?.value as? [String:Any] else {return}
				for messages in dict {
					guard let messageDict = messages.value as? [String:Any] else {return}
					let send = Message(dictionary: messageDict)
					self.userMessages.append(send)
					
 				}
				print(self.userMessages)
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}else {
				print(err?.localizedDescription ?? "")
			}
		}
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return userMessages.count
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! HomeCell
		cell.message = userMessages[indexPath.row]
		return cell
	}
}
