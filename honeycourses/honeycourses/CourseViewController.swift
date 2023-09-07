//
//  CourseViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class CourseViewController: BaseViewController {
	
	lazy var courseView = CourseView(controller: self)
	
	var courseService: CourseService?
	var tokenService: TokenService?
	
	private(set) var currentCourses: Courses?
	private var courses: Courses? {
		didSet { self.currentCourses = self.courses }
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}
	
	override func loadView() {
		self.view = courseView
	}
	
}

extension CourseViewController {
	// 수업 목록을 갱신하는 메서드
	// 2개의 상황이 있을 수 있어요.
	// 1. CourseListCategory가 All일 경우
	// 2. CourseListCategory가 All이 아닐 경우
	@objc func loadData() {
		courseView.startLoading()
		
		Task {
			self.courses = await requestCourses()
			courseView.changeCurrentListCourseCategory(.all)
		}
	}
	
	private func requestCourses() async -> Courses {
		guard let token = await tokenService?.idToken() else { return [] }
		guard let courses = await courseService?.requestCourses(token: token) else { return [] }
		return courses
	}
}

extension CourseViewController {
	func courseListCategoryMenuDidTap(_ courseListCategory: CourseListCategory) {
		courseView.startLoading()
		currentCourses = courses?.filtered(by: courseListCategory)
		courseView.stopLoading()
	}
}

extension CourseViewController {
	@objc func addCourseButtonDidTap() {
		// TODO: 수업 추가 화면으로 이동
		print("수업 추가 화면으로 이동")
	}
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentCourses?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView
			.dequeueReusableCell(withIdentifier: CourseTableViewCell.identifier) as? CourseTableViewCell,
					let currentCourses
		else { return CourseTableViewCell() }
		cell.bind(currentCourses[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let course = currentCourses?[indexPath.row] else { return }
		routeToCourseReview(course)
	}
	
}

extension CourseViewController {
	func routeToCourseReview(_ course: Course) {
		let courseReviewController = CourseReviewViewController()
		let courseReviewService = CourseReviewServiceImplement(networkService: NetworkServiceImplement.shared)
		courseReviewController.courseReviewService = courseReviewService
		courseReviewController.tokenService = tokenService
		courseReviewController.courseID = course.id
		self.navigationController?.pushViewController(courseReviewController, animated: true)
	}
}
