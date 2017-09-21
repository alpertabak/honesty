//
//  HomeCell.swift
//  honestyApp
//
//  Created by Alper Tabak on 21.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
	var message: Message? {
		didSet {
			messageTV.text = message?.message
		}
	}
	let messageTV: UITextView = {
		let tv = UITextView()
		tv.isUserInteractionEnabled = false
		let txtString = "alper tabak ve maceraları"
		let style = NSMutableParagraphStyle()
		style.lineSpacing = 1.5
		let attributes = [NSAttributedStringKey.paragraphStyle : style]
		tv.attributedText = NSAttributedString(string: txtString, attributes: attributes)
		tv.textColor = .black
		tv.font = UIFont.systemFont(ofSize: 16)
		tv.isScrollEnabled = false
		tv.isUserInteractionEnabled = false
		tv.sizeToFit()
		return tv
	}()
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(messageTV)
		messageTV.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, height: 0, width: 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
