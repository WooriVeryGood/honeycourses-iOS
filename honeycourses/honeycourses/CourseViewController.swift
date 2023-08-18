//
//  CourseViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class CourseViewController: BaseViewController {
	
	private lazy var courseView = CourseView(controller: self)
	
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
		// TODO: tableView 데이터 변경
		Task {
			guard let token = await TokenServiceImplement.shared.idToken()
			else {
				return
			}
			if let dataString = await CourseServiceImplement(networkService: NetworkServiceImplement.shared)
				.requestList(token: token) {
				print(dataString)
			}
		}
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
