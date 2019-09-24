//
//  TableViewDataSource.swift
//  weatherApp
//
//  Created by Zach Chen on 5/9/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject {
	
	var tableViewModel = TableViewModel()
	
}

extension TableViewDataSource: UITableViewDataSource {
	
	// sections
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.cities.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return tableViewModel.cities[section]
	}
	
	// rows
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.weatherInformation.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubtitleTableViewCell
		
		// FIXME: move to cellViewModel
		cell.textLabel?.text = tableViewModel.weatherTitle[indexPath.row]
		cell.detailTextLabel?.text = tableViewModel.weatherInformation[indexPath.row]
		return cell
	}
}
