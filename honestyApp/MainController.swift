//
//  MainController.swift
//  honestyApp
//
//  Created by Alper Tabak on 20.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit
import FirebaseAuth
class MainController: UIViewController {
	let logoutButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Logout", titleColor: Colors.projectBlue, fontType: "bold", fontSize: 18, background: nil, cornerRadius: nil)
		button.addTarget(self, action: #selector(logout), for: .touchUpInside)
		button.sizeToFit()
		return button
	}()
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
			}else {
				print("kullanıcımız var dostum")
			}
		}
		view.addSubview(logoutButton)
		logoutButton.frame = CGRect(x: view.frame.width - logoutButton.frame.width - 20, y: 80, width: logoutButton.frame.size.width, height: logoutButton.frame.size.height)
		print("Welcome on aboard")
	}
	@objc func logout(){
		do{
			try Auth.auth().signOut()
			let loginVC = UINavigationController(rootViewController: LoginController())
			self.present(loginVC, animated: true, completion: nil)
			return
		}catch{
			print("Olmadı")
		}
	}
}
