//
//  SearchCell.swift
//  honestyApp
//
//  Created by Alper Tabak on 21.09.2017.
//  Copyright © 2017 alpertabak. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
	var user: User? {
		didSet{
			guard let username = user?.username else {return}
			usernameLabel.text = username
		}
	}
	let userProfileImageView: UIImageView = {
		let image = #imageLiteral(resourceName: "noUserPic")
		let iv = UIImageView()
		iv.image = image
		iv.backgroundColor = .blue
		iv.layer.cornerRadius = 25
		iv.contentMode = .scaleAspectFit
		iv.clipsToBounds = true
		return iv
	}()
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.text = "alpernatif"
		return label
	}()
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(userProfileImageView)
		addSubview(usernameLabel)
		userProfileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 50, width: 50)
		userProfileImageView.anchorCenter(x: nil, xCons: 0, y: centerYAnchor, yCons: 0)
		usernameLabel.anchor(top: nil, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
		usernameLabel.anchorCenter(x: nil, xCons: 0, y: centerYAnchor, yCons: 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
