//
//  MainController.swift
//  honestyApp
//
//  Created by Alper Tabak on 20.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit
import FirebaseAuth
class MainController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		Auth.auth().addStateDidChangeListener { (auth, user) in
			if user == nil {
				DispatchQueue.main.async {
					let loginVC = UINavigationController(rootViewController: LoginController())
					self.present(loginVC, animated: true, completion: nil)
				}
				return
			}
		let homeVC = HomeController()
		let userProfileVC = UserProfileController()
		let searchVC = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
		homeVC.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
		homeVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
		searchVC.tabBarItem.image = #imageLiteral(resourceName: "search_unselected")
		searchVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "search_selected")
		userProfileVC.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
		userProfileVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
		let homeController = UINavigationController(rootViewController: homeVC)
		let searchController = UINavigationController(rootViewController: searchVC)
		let navController = UINavigationController(rootViewController: userProfileVC)
		self.tabBar.tintColor = .black
		self.viewControllers = [homeController,navController,searchController]
	}
	}
}
