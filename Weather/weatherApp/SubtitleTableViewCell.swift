//
//  SubtitleTableViewCell.swift
//  weatherApp
//
//  Created by Zach Chen on 9/24/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {
	
	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
