//
//  NetworkServiceSpy.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import Foundation
@testable import honeycourses

final class NetworkServiceSpy: NetworkService {
	
	var token: String?
	var urlString: String?
	
	func request(queryString: String, token: String) async -> Data? {
		urlString = "https://api.honeycourses.com\(queryString)"
		self.token = token
		return nil
	}
	
}
