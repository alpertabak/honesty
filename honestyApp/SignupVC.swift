//
//  ViewController.swift
//  sarahahClone
//
//  Created by Alper Tabak on 17.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UITextFieldDelegate {
	
	let emailLabel: UILabel = {
		let label = UILabel()
		label.text = "YOUR EMAIL"
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.sizeToFit()
		return label
	}()
	lazy var emailTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "name@domain.com"
		tf.font = UIFont.boldSystemFont(ofSize: 24)
		tf.delegate = self
		return tf
	}()
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.text = "YOUR USERNAME"
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.sizeToFit()
		return label
	}()
	lazy var usernameTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "@ yourusername"
		tf.font = UIFont.boldSystemFont(ofSize: 24)
		tf.delegate = self
		return tf
	}()
	let passwordLabel: UILabel = {
		let label = UILabel()
		label.text = "YOUR PASSWORD"
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.sizeToFit()
		return label
	}()
	lazy var passwordTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Min 8 symbols"
		tf.font = UIFont.boldSystemFont(ofSize: 24)
		tf.delegate = self
		return tf
	}()
	let loginButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Sign Up", titleColor: .white, fontType: "bold", fontSize: 18, background: Colors.projectBlue, cornerRadius: 6)
		button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
		return button
	}()
	let signUpButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Login", titleColor: UIColor.rgb(red: 111, green: 111, blue: 111), fontType: "normal", fontSize: 16, background: nil, cornerRadius: nil)
		button.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
		button.sizeToFit()
		return button
	}()
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.emailTextField.resignFirstResponder()
		self.usernameTextField.resignFirstResponder()
		self.passwordTextField.resignFirstResponder()
		return false
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(emailLabel)
		view.addSubview(emailTextField)
		view.addSubview(usernameLabel)
		view.addSubview(usernameTextField)
		view.addSubview(passwordLabel)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		view.addSubview(signUpButton)
		
		
		emailLabel.frame = CGRect(x: 30, y: 80, width: emailLabel.frame.size.width, height: emailLabel.frame.size.height)
		emailTextField.frame = CGRect(x: emailLabel.frame.origin.x, y: emailLabel.frame.maxY + 12, width: view.frame.size.width - (emailLabel.frame.origin.x * 2), height: 24)
		
		
		usernameLabel.frame = CGRect(x: 30, y: emailTextField.frame.maxY + 25, width: usernameLabel.frame.size.width, height: usernameLabel.frame.size.height)
		usernameTextField.frame = CGRect(x: usernameLabel.frame.origin.x, y: usernameLabel.frame.maxY + 12, width: view.frame.size.width - (usernameLabel.frame.origin.x * 2), height: 24)
		
		passwordLabel.frame = CGRect(x: 30, y: usernameTextField.frame.maxY + 25, width: passwordLabel.frame.size.width, height: passwordLabel.frame.size.height)
		passwordTextField.frame = CGRect(x: passwordLabel.frame.origin.x, y: passwordLabel.frame.maxY + 12, width: view.frame.size.width - (passwordLabel.frame.origin.x * 2), height: 24)
		
		
		loginButton.frame = CGRect(x: 30, y: view.frame.size.height - 50 - 50 , width: view.frame.size.width - 60, height: 50)
		signUpButton.frame = CGRect(x: view.frame.width / 2 - signUpButton.frame.width / 2, y: view.frame.height - signUpButton.frame.height - 10, width: signUpButton.frame.width, height: signUpButton.frame.height)
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = false
	}
	
	@objc func handleSignUp(){
		guard let email = emailTextField.text, email.characters.count > 0 else {return}
		guard let username = usernameTextField.text, username.characters.count > 0 else {return}
		guard let password = passwordTextField.text, password.characters.count > 0  else {return}
		AuthService.instance.registerUser(withEmail: email, andUsername: username, andPassword: password) { (success, err) in
			if success {
				AuthService.instance.loginUser(withEmail: email, andPassword: password, completion: { (success, loginErr) in
					if success {
						self.dismiss(animated: true, completion: nil)
						print("alright mate alright")
					}else {
						print(loginErr?.localizedDescription ?? "")
					}
				})
			}else {
				print("Hata: \(String(describing: err?.localizedDescription))")
			}
		}
	}
	@objc func goLogin(){
		self.navigationController?.popViewController(animated: true)
	}
	
	
	
}



