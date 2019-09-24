//
//  ViewController.swift
//  weatherApp
//
//  Created by Zach Chen on 5/9/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Notifications
extension Notification.Name {
	static let reloadTable = Notification.Name("reloadTable")
}

class ViewController: UIViewController {

	// MARK: - Properties
	
	var tableView: TableView! { return self.view as? TableView }
	var tableViewDataSource = TableViewDataSource()
	var locationManager = CLLocationManager()
	var latitude: Double?
	var longitude: Double?
	
	// MARK: - Lifecycle Methods
	
	override func loadView() {
		view = TableView(frame: UIScreen.main.bounds)
		self.tableView.tableView.delegate = self
		self.tableView.tableView.dataSource = tableViewDataSource
		locationManager.delegate = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.requestWhenInUseAuthorization()
		updateLocation(locationManager: locationManager)
		addNotificationObservers()
	}

	// MARK: - Methods
	func addNotificationObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: .reloadTable, object: nil)
	}
	
	private func updateWeather() {
		if let lat = latitude,
			let lon = longitude {
			tableViewDataSource.tableViewModel.getSearchResults(lat: String(lat), lon: String(lon), apiKey: "898dd139c0958df2300d6dfa05432044")
		}
	}
	
	@objc private func reloadTable() {
		DispatchQueue.main.async {
			print(self.tableViewDataSource.tableViewModel.weatherInformation as Any)
			print(self.tableViewDataSource.tableViewModel.weatherTitle as Any)
			print(self.tableViewDataSource.tableViewModel.cities as Any)
			self.tableView.tableView.reloadData()
		}
	}
	
}

extension ViewController: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
		switch status {
		case .authorizedAlways,
			 .authorizedWhenInUse:
			updateLocation(locationManager: manager)

		default:
			return
		}
	}
	
	private func updateLocation(locationManager: CLLocationManager) {
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()
		latitude = locationManager.location?.coordinate.latitude
		longitude = locationManager.location?.coordinate.longitude
		
		// once the location has been updated, update the weather
		updateWeather()
	}
}

extension ViewController: UITableViewDelegate {
	
}
