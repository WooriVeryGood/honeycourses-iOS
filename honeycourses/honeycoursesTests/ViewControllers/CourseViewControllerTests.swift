//
//  CourseViewControllerTests.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import Combine
import XCTest
@testable import honeycourses

final class CourseViewControllerTests: XCTestCase {
	
	private var networkService: NetworkServiceSpy?
	private var tokenService: TokenServiceStub?
	private var courseService: CourseServiceSpy?
	private var viewController: CourseViewController?
	
	private var cancellable = Set<AnyCancellable>()
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		networkService = NetworkServiceSpy()
		tokenService = TokenServiceStub()
		courseService = CourseServiceSpy()
		viewController = CourseViewController()
		viewController?.courseService = courseService
		viewController?.tokenService = tokenService
	}
	
	override func tearDownWithError() throws {
		try super.tearDownWithError()
		networkService = nil
		tokenService = nil
		courseService = nil
		viewController = nil
		cancellable.removeAll()
	}
	
	func test_requestCourses() async {
		await requestCourses()
		
		// then
		XCTAssertEqual(courseService?.token, "dummyIDToken")
		XCTAssertEqual(courseService?.urlString, "https://api.honeycourses.com/courses")
	}
	
	@MainActor
	func test_tableViewConfigureCell() async {
		await requestCourses()

		let tableView = viewController?.courseView.tableView
		let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0))
		XCTAssertEqual(cell?.textLabel?.text, "计算机系统导论")
	}
	
	@MainActor
	private func requestCourses() async {
		let expectation = XCTestExpectation(description: "Request data asynchronously.")
		courseService?.$requestListIsCalled
			.sink { isCalled in
				if isCalled {
					expectation.fulfill()
				}
			}
			.store(in: &cancellable)
		let _ = viewController?.loadData()
		await fulfillment(of: [expectation])
	}
	
}
