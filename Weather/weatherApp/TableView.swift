//
//  TableView.swift
//  weatherApp
//
//  Created by Zach Chen on 5/9/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import UIKit

class TableView: UIView {
	
	// MARK: - Properties
	let tableView = UITableView()
	
	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Methods
	private func configureViewModifications() {
		tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.estimatedRowHeight = 50
		tableView.rowHeight = UITableView.automaticDimension
	}
	
	private func configureView() {
		
		configureViewModifications()
		
		addSubview(tableView)
		tableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		tableView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		tableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		tableView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
	}
}
