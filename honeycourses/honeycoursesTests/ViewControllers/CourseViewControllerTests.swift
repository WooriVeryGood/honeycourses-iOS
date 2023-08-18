//
//  CourseViewControllerTests.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import XCTest
@testable import honeycourses

final class CourseViewControllerTests: XCTestCase {
	
	@MainActor
	func test_requestCourseLists() async {
		// given
		let courseService = CourseServiceSpy()
		let viewController = CourseViewController()
		viewController._courseService = courseService
		
		// when
		let _ = await viewController.requestCourseLists(token: "dummy token")
		
		// then
		XCTAssertEqual(courseService.token, "dummy token")
		XCTAssertEqual(courseService.urlString, "https://api.honeycourses.com/courses")
	}
	
}
