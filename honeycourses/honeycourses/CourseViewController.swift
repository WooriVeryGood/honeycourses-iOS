//
//  CourseViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class CourseViewController: BaseViewController {
	
	private lazy var _courseView = CourseView(controller: self)
	var courseView: CourseView {
		get { _courseView }
	}
	
	var courseService: CourseService?
	var tokenService: TokenService?
	
	private var courses: Courses?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}
	
	override func loadView() {
		self.view = courseView
	}
	
}

extension CourseViewController {
	@objc func loadData() {
		courseView.startLoading()
		
		Task {
			self.courses = await requestCourses()
			courseView.stopLoading()
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
		// TODO: tableView 데이터 변경
		print("\(courseListCategory.title) did tap")
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
		return courses?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = courses?[indexPath.row].name ?? "none"
		return cell
	}
	
}
