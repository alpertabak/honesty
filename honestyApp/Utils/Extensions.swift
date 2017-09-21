//
//  Extensions.swift
//  movquat
//
//  Created by Alper Tabak on 29.07.2017.
//  Copyright © 2017 Mosquat. All rights reserved.
//
import UIKit
extension UIColor {
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
	}
}
extension UIView {
	/* UIView'in genişlik ve yükseklik değerlerini almak için*/
	func width() -> CGFloat{
		return self.frame.size.width
	}
	func height() -> CGFloat{
		return self.frame.size.height
	}
	
	func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, height: CGFloat, width: CGFloat){
		translatesAutoresizingMaskIntoConstraints = false
		if let top = top {
			self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}
		if let left = left {
			self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}
		if let bottom = bottom {
			self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
		}
		if let right = right {
			self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
		}
		
		if height != 0 {
			self.heightAnchor.constraint(equalToConstant: height).isActive = true
		}
		if width != 0 {
			self.widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		
	}
	func setSizes(width: CGFloat, height: CGFloat){
		if width != 0 {
			self.widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		if height != 0 {
			self.heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
	func anchorCenter(x:NSLayoutXAxisAnchor?,xCons: CGFloat,y: NSLayoutYAxisAnchor?,yCons: CGFloat){
		translatesAutoresizingMaskIntoConstraints = false
		if let x = x {
			if xCons != 0 {
				self.centerXAnchor.constraint(equalTo: x, constant: xCons).isActive = true
			}else {
				self.centerXAnchor.constraint(equalTo: x).isActive = true
			}
		}
		if let y = y {
			if yCons != 0 {
				self.centerYAnchor.constraint(equalTo: y, constant: yCons).isActive = true
			}else {
				self.centerYAnchor.constraint(equalTo: y).isActive = true
			}
		}
		
	}
	func sizeAnchor(height: CGFloat, width:CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		if height != 0 {
			self.heightAnchor.constraint(equalToConstant: height).isActive = true
		}
		if width != 0 {
			self.widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}
	
	func setGradientBackground(colorOne: UIColor, colorTwo: UIColor,startX: CGFloat, startY:CGFloat,endX:CGFloat,endY:CGFloat) {
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = CGPoint(x: startX, y: startY)
		gradientLayer.endPoint = CGPoint(x: endX, y: endY)
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
	func setShadow(width:CGFloat?,height:CGFloat?,opacity:Float?,radius:CGFloat?){
		layer.shadowColor = UIColor.init(white: 0, alpha: 0.1).cgColor
		layer.shadowOffset = CGSize(width: width!, height: height!)
		layer.shadowOpacity = opacity!
		layer.shadowRadius = radius!
		layer.masksToBounds = false
	}
	
	
}

extension UIButton {
	func createButton(title:String?,titleColor:UIColor?,fontType:String?,fontSize:CGFloat?,background:UIColor?,cornerRadius: CGFloat?){
		if let title = title {
			self.setTitle(title,for: .normal)
		}
		if let titleColor = titleColor {
			self.setTitleColor(titleColor, for: .normal)
		}
		if let fontType = fontType {
			if let fontSize = fontSize {
				if fontType == "bold"{
					self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
				}
				if fontType == "normal"{
					self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
				}
			}
		}
		if let background = background {
			self.backgroundColor = background
		}
		if let cornerRadius = cornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
	}
	
	func buttonInsidePadding(top:CGFloat?,bottom:CGFloat?,left:CGFloat?,right:CGFloat?){
		if let top = top , let bottom = bottom , let left = left , let right = right {
			self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
		}
	}
	func colorTitle(text: String?, coloredText: String?, color: UIColor?) {
		
		let attributedString = NSMutableAttributedString(string: text!)
		let range = (text! as NSString).range(of: coloredText!)
		attributedString.setAttributes([NSAttributedStringKey.foregroundColor: color!],
		                               range: range)
		self.setAttributedTitle(attributedString, for: .normal)
	}
	func underlinedButtonTitle(title:String?,fontSize:CGFloat?, titleColor: UIColor?){
		if let title = title, let fontSize = fontSize, let titleColor = titleColor {
			let attributes : [NSAttributedStringKey: Any] = [
				NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: fontSize),
				NSAttributedStringKey.foregroundColor : titleColor,
				NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
			let attributedString = NSMutableAttributedString(string: "\(title)", attributes: attributes)
			self.setAttributedTitle(attributedString, for: .normal)
		}
	}
	
	func createWithImage(image:String?,renderingMode:String?,tintColor: UIColor?){
		var imageString: UIImage?
		if let image = image {
			imageString = UIImage(named: image)
		}
		if let renderingMode = renderingMode {
			if renderingMode == "template" {
				self.setImage(imageString?.withRenderingMode(.alwaysTemplate), for: .normal)
			}
			if renderingMode == "original" {
				self.setImage(imageString?.withRenderingMode(.alwaysOriginal), for: .normal)
			}
		}
		if let tintColor = tintColor {
			self.tintColor = tintColor
		}
	}
	func setBackgroundColor(color: UIColor, forState: UIControlState) {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
		UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let colorImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		self.setBackgroundImage(colorImage, for: forState)
	}
}

extension UIImageView {
	func roundImage(par: CGFloat){
		self.layer.masksToBounds = true
		self.layer.cornerRadius = par / 2
	}
}
extension UITextField {
	func createTextField(placeholder: String?,placeholderColor: UIColor?,background: UIColor?,cornerRadius: CGFloat?,textColor: UIColor?,font:String?, fontSize:CGFloat?){
		self.translatesAutoresizingMaskIntoConstraints = false
		if let placeholder = placeholder {
			self.placeholder = placeholder
		}
		if let background = background {
			self.backgroundColor = background
		}
		if let cornerRadius = cornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
		if let textColor = textColor {
			self.textColor = textColor
		}
		if let font = font {
			if let fontSize = fontSize {
				if font == "normal" {
					self.font = UIFont.systemFont(ofSize: fontSize)
				}
				if font == "bold"{
					self.font = UIFont.boldSystemFont(ofSize: fontSize)
				}
				if font == "medium" {
					self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
				}
			}
		}
		if let placeholderColor = placeholderColor {
			self.setValue(placeholderColor, forKeyPath: "_placeholderLabel.textColor")
		}
		
	}
	
	
	func addSpaceView(left:Bool?,right:Bool?,width:CGFloat?){
		if let width = width {
			let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
			
			if left == true {
				self.leftView = spaceView
				self.leftViewMode = .always
			}
			if right == true {
				self.rightView = spaceView
				self.rightViewMode = .always
			}
		}
	}
	func setBottomBorder(x:CGFloat,y:CGFloat,z:CGFloat) {
		self.borderStyle = .none
		self.layer.backgroundColor = UIColor.white.cgColor
		self.layer.sublayerTransform = CATransform3DMakeTranslation(x,y , z)
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.lightGray.cgColor
		self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
		self.layer.shadowOpacity = 1.0
		self.layer.shadowRadius = 0.0
	}
	
}
extension UINavigationController
{
	/*override open var preferredStatusBarStyle: UIStatusBarStyle {
		get {
			return .lightContent
		}
	}*/
	
}

extension UISearchBar {
	
	private func getViewElement<T>(type: T.Type) -> T? {
		
		let svs = subviews.flatMap { $0.subviews }
		guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
		return element
	}
	
	func getSearchBarTextField() -> UITextField? {
		
		return getViewElement(type: UITextField.self)
	}
	
	func setTextColor(color: UIColor) {
		
		if let textField = getSearchBarTextField() {
			textField.textColor = color
		}
	}
	
	func setTextFieldColor(color: UIColor) {
		
		if let textField = getViewElement(type: UITextField.self) {
			switch searchBarStyle {
			case .minimal:
				textField.layer.backgroundColor = color.cgColor
				textField.layer.cornerRadius = 6
				
			case .prominent, .default:
				textField.backgroundColor = color
			}
		}
	}
	
	func setPlaceholderTextColor(color: UIColor) {
		
		if let textField = getSearchBarTextField() {
			textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: color])
		}
	}
	
	/*func setTextFieldClearButtonColor(color: UIColor) {
	
	if let textField = getSearchBarTextField() {
	
	let button = textField.value(forKey: "clearButton") as! UIButton
	if let image = button.imageView?.image {
	button.setImage(image.transform(withNewColor: color), for: .normal)
	}
	}
	}
	
	func setSearchImageColor(color: UIColor) {
	
	if let imageView = getSearchBarTextField()?.leftView as? UIImageView {
	imageView.image = imageView.image?.transform(withNewColor: color)
	}
	}*/
}


