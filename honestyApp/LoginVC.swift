//
//  ViewController.swift
//  sarahahClone
//
//  Created by Alper Tabak on 17.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
	
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
		let button = UIButton()
		button.createButton(title: "Forgot", titleColor: Colors.projectBlue, fontType: "bold", fontSize: 12, background: nil, cornerRadius: nil)
		button.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
		button.sizeToFit()
		button.frame.origin.y = tf.frame.height / 2 - button.frame.height / 2
		tf.rightViewMode = .always
		tf.rightView = button
		return tf
	}()
	let loginButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Login", titleColor: .white, fontType: "bold", fontSize: 18, background: Colors.projectBlue, cornerRadius: 6)
		button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
		return button
	}()
	let signUpButton: UIButton = {
		let button = UIButton()
		button.createButton(title: "Sign Up", titleColor: UIColor.rgb(red: 111, green: 111, blue: 111), fontType: "normal", fontSize: 16, background: nil, cornerRadius: nil)
		button.addTarget(self, action: #selector(goSignUp), for: .touchUpInside)
		button.sizeToFit()
		return button
	}()
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.emailTextField.resignFirstResponder()
		self.passwordTextField.resignFirstResponder()
		forgotPassword()
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
		view.addSubview(passwordLabel)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		view.addSubview(signUpButton)
		
		
		emailLabel.frame = CGRect(x: 30, y: 40, width: emailLabel.frame.size.width, height: emailLabel.frame.size.height)
		emailTextField.frame = CGRect(x: emailLabel.frame.origin.x, y: emailLabel.frame.maxY + 12, width: view.frame.size.width - (emailLabel.frame.origin.x * 2), height: 24)
		
		passwordLabel.frame = CGRect(x: 30, y: emailTextField.frame.maxY + 25, width: passwordLabel.frame.size.width, height: passwordLabel.frame.size.height)
		passwordTextField.frame = CGRect(x: passwordLabel.frame.origin.x, y: passwordLabel.frame.maxY + 12, width: view.frame.size.width - (passwordLabel.frame.origin.x * 2), height: 24)
		
		
		loginButton.frame = CGRect(x: 30, y: view.frame.size.height - 50 - 50 , width: view.frame.size.width - 60, height: 50)
		signUpButton.frame = CGRect(x: view.frame.width / 2 - signUpButton.frame.width / 2, y: view.frame.height - signUpButton.frame.height - 10, width: signUpButton.frame.width, height: signUpButton.frame.height)
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}
	@objc func handleLogin(){
		guard let email = emailTextField.text, email.characters.count > 0 else {return}
		guard let password = passwordTextField.text, password.characters.count > 0 else {return}
		AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, err) in
			if success {
				self.dismiss(animated: true, completion: nil)
			}else {
				print(err?.localizedDescription)
			}
		}
	}
	@objc func forgotPassword(){
		print("forgot password")
	}
	@objc func goSignUp(){
		navigationController?.pushViewController(SignUpController(), animated: true)
	}
	
	
	
}


