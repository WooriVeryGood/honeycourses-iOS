//
//  CourseServiceTests.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import XCTest
@testable import honeycourses

final class CourseServiceTests: XCTestCase {
	func test_requestList() async {
		// given
		let networkServiceSpy = NetworkServiceSpy()
		let service = CourseServiceImplement(networkService: networkServiceSpy)
		
		// when
		await service.requestList(token: "dummy token")
		
		// then
		XCTAssertEqual(networkServiceSpy.token, "dummy token")
		XCTAssertEqual(networkServiceSpy.urlString, "https://api.honeycourses.com/courses")
	}
	
	
}
