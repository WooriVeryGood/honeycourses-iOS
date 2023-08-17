//
//  CourseServiceTest.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/17.
//

import XCTest
@testable import honeycourses

final class NetworkManagerSpy: NetworkManger {
	
	private let baseURL = "https://api.honeycourses.com"
	
	var urlString: String?
	
	func performRequest(queryString: String, completion: @escaping (Result<Data, honeycourses.NetworkError>) -> Void) {
		urlString = baseURL + queryString
	}
	
	
}

final class CourseServiceTest: XCTestCase {
	func testRequestList_returnSuccess() {
		// given
		let networkManager = NetworkManagerSpy()
		
		// when
//		CourseService(networkManager: networkManager)
			.requestList(completionHandler: { _ in })
		
		// then
		
	}
}
