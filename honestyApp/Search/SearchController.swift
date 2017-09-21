//
//  SearchController.swift
//  honestyApp
//
//  Created by Alper Tabak on 21.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit
import FirebaseDatabase
class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
	var users = [User]()
	var filteredUsers = [String]()
	lazy var searchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.placeholder = "Enter an @username"
		sb.barTintColor = .gray
		UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
		sb.delegate = self
		return sb
	}()
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.collectionView?.endEditing(true)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = .white
		let navBar = navigationController?.navigationBar
		navBar?.addSubview(searchBar)
		collectionView?.delegate = self
		collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: "cellId")
		searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, height: 0, width: 0)
		navigationItem.title = "Search"
		collectionView?.alwaysBounceVertical = true
		collectionView?.keyboardDismissMode = .onDrag
		
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		searchBar.isHidden = false
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillAppear(animated)
		searchBar.isHidden = true
	}
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if (searchBar.text?.isEmpty)! {
			self.users.removeAll()
			self.collectionView?.reloadData()
		}else {
			searchUser(searchText: searchBar.text!.lowercased())
		}
		searchBar.resignFirstResponder()
	}
	fileprivate func searchUser(searchText: String){
		let usernick = searchText
		
		Database.database().reference().child("users").queryOrdered(byChild: "username").queryStarting(atValue:usernick).queryEnding(atValue: usernick +  "\u{f8ff}").observe(.value) { (snapshot) in
			
			if snapshot.exists() {
				var results = [User]()
				if let dict = snapshot.value as? [String:Any] {
					dict.forEach({ (key,val) in
						
						guard let value = val as? [String:Any] else {return}
						let user = User(uid: key, dictionary: value)
						results.append(user)
						
					})
					self.users = results
				}
			}else {
				let alertView = UIAlertController(title: "Error", message: "There is no user with this name", preferredStyle: .alert)
				let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
				alertView.addAction(alertAction)
				self.present(alertView, animated: true, completion: nil)
				self.users.removeAll()
			}
			print(self.users)
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}
			
		}
		
	}
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		searchBar.isHidden = true
		searchBar.resignFirstResponder()
		let user = users[indexPath.item]
		
		let userProfileController = UserProfileController()
		userProfileController.userId = user.uid
		self.navigationController?.pushViewController(userProfileController, animated: true)
	}
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return users.count
	}
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchCell
		cell.user = users[indexPath.row]
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 66)
	}
}
