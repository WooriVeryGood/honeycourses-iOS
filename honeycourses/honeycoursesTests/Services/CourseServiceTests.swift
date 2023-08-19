//
//  CourseServiceTests.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import XCTest
@testable import honeycourses

final class CourseServiceTests: XCTestCase {
	
	private var networkService: NetworkServiceSpy?
	private var service: CourseService?
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		networkService = NetworkServiceSpy()
		service = CourseServiceImplement(networkService: networkService!)
	}
	
	override func tearDownWithError() throws {
		try super.tearDownWithError()
		networkService = nil
		service = nil
	}
	
	func test_requestList() async {
		// when
		await service?.requestCourses(token: "dummy token")
		
		// then
		XCTAssertEqual(networkService?.token, "dummy token")
		XCTAssertEqual(networkService?.urlString, "https://api.honeycourses.com/courses")
	}
	
	
}
