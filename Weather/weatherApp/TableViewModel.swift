//
//  TableViewModel.swift
//  weatherApp
//
//  Created by Zach Chen on 9/24/19.
//  Copyright © 2019 Zach Chen. All rights reserved.
//

import Foundation

class TableViewModel {
	
	var cities = [String]()
	var weatherTitle = [String]()
	var weatherInformation = [String]()

	// MARK: GET REQUEST
	
	// initialize URLSession w/ a default session configuration
	let defaultSession = URLSession(configuration: .default)
	
	// declare a URLSessionDataTask variable that we'll use for an HTTP GET request. Will be re-initialized for each new search
	var dataTask: URLSessionDataTask?
	
	func getSearchResults(lat: String, lon: String, apiKey: String) {
		
		// cancel the data task if it already exists, so we can reuse the data task object
		dataTask?.cancel()
		
		// to include the city in the query URL, create a URLComponents object from the API base URL
		if var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") {
			
			// set its query string to ensure that characters are properly escaped
			urlComponents.queryItems = [URLQueryItem(name: "lat", value: lat), URLQueryItem(name: "lon", value: lon), URLQueryItem(name: "appid", value: apiKey)]
			
			// the url property of urlComponents might be nil b/c of improper percent encoding so use optional binding
			guard let url = urlComponents.url else { return }
			
			// from the defaultSession we created, initialize a URLSessionDataTask with the url we just created
			dataTask = defaultSession.dataTask(with: URLRequest(url: url)) { data, response, error in
				
				// TODO: If the HTTP request is successful, parse the response data into the appropriate array
				if let error = error {
					print(error.localizedDescription as Any)
				}
				
				if let data = data {
					self.parseJSON(data: data)
				}
			}
			
			// all tasks start in a suspended state by default. calling resume() starts the data task
			dataTask?.resume()
		}
	}

	func parseJSON(data: Data) {
		guard let receivedData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
		let name = receivedData["name"] as! String
		let main = receivedData["main"] as! [String: Any]

		// add to array
		cities.append(name)
		for i in main {
			weatherTitle.append(i.key)
			weatherInformation.append("\(i.value)")
		}
		
		NotificationCenter.default.post(name: .reloadTable, object: nil)
	}
	
}
