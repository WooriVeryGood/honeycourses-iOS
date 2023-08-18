//
//  CourseViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class CourseViewController: BaseViewController {
	
	private lazy var courseView = CourseView(controller: self)
	
	var _courseService: CourseService?
	var _tokenService: TokenService?
	
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
		defer { courseView.stopLoading() }
		
		Task {
			guard let token = await _tokenService?.idToken()else {return}
			if let dataString = await requestCourseLists(token: token) {
				print(dataString)
			}
		}
	}
	
	func requestCourseLists(token: String) async -> String? {
		return await _courseService?.requestList(token: token)
	}
}

extension CourseViewController {
	func courseCategoryMenuDidTap(_ courseCategory: CourseCategory) {
		// TODO: tableView 데이터 변경
		print("\(courseCategory.title) did tap")
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
		return 100
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = "\(indexPath.row)"
		return cell
	}
	
}
