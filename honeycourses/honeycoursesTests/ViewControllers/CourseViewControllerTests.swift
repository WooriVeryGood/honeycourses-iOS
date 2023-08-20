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
	func test_tableViewConfigureCell_Not_isYouguan() async {
		await requestCourses()

		let tableView = viewController?.courseView.tableView
		let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as? CourseTableViewCell
		XCTAssertEqual(cell?.nameLabel.text, "计算机系统导论")
		XCTAssertEqual(cell?.creditLabel.text, "5점")
		XCTAssertEqual(cell?.categoryLabel.text, "专业课")
		XCTAssertEqual(cell?.departmentLabel.text, "信息科学技术学院")
		XCTAssertEqual(cell?.youguanLabel.isHidden, true)
		XCTAssertEqual(cell?.youguanLabel.text, "")
	}
	
	@MainActor
	func test_tableViewConfigureCell_isYouguan() async {
		await requestCourses()
		
		let tableView = viewController?.courseView.tableView
		let cell = tableView?
			.dataSource?
			.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0)) as? CourseTableViewCell
		XCTAssertEqual(cell?.youguanLabel.isHidden, false)
		XCTAssertEqual(cell?.youguanLabel.text, "中国有关")
	}
	
	@MainActor
	func test_courseListCategoryMenuDidTap_all() async {
		await requestCourses()
		
		viewController?.courseListCategoryMenuDidTap(.all)
		
		// Test count
		XCTAssertEqual(viewController?.currentCourses?.count, 3)
	}
	
	@MainActor
	func test_courseListCategoryMenuDidTap_major() async {
		await requestCourses()
		
		viewController?.courseListCategoryMenuDidTap(.major)
		
		// Test count
		XCTAssertEqual(viewController?.currentCourses?.count, 2)
		// Test course
		let tableView = viewController?.courseView.tableView
		let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as? CourseTableViewCell
		XCTAssertEqual(cell?.nameLabel.text, "计算机系统导论")
		XCTAssertEqual(cell?.categoryLabel.text, "专业课")
	}
	
	@MainActor
	func test_courseListCategoryMenuDidTap_elective() async {
		await requestCourses()
		
		viewController?.courseListCategoryMenuDidTap(.elective)
		
		// Test count
		XCTAssertEqual(viewController?.currentCourses?.count, 1)
		// Test course
		let tableView = viewController?.courseView.tableView
		let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as? CourseTableViewCell
		XCTAssertEqual(cell?.nameLabel.text, "社会性别研究")
		XCTAssertEqual(cell?.categoryLabel.text, "通选课")
	}
	
	@MainActor
	func test_courseListCategoryMenuDidTap_china() async {
		await requestCourses()
		
		viewController?.courseListCategoryMenuDidTap(.china)
		
		// Test count
		XCTAssertEqual(viewController?.currentCourses?.count, 1)
		// Test course
		let tableView = viewController?.courseView.tableView
		let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as? CourseTableViewCell
		XCTAssertEqual(cell?.nameLabel.text, "中国历史文选B（上）")
//		XCTAssertEqual(cell?.youguanLabel, "通选课")
	}
	
	@MainActor
	private func requestCourses() async {
		let expectation = XCTestExpectation(description: "Request data asynchronously.")
		courseService?.$requestCoursesIsCalled
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
