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
		// TODO: tableView 데이터 변경
		CourseServiceImplement(networkManager: NetworkManagerImplement.shared)
			.requestList { [weak self] result in
				switch result {
				case .success(let dataString):
					print(dataString)
				case .failure(let error):
					print("load data fail")
					print(error.localizedDescription)
				}
				DispatchQueue.main.async {
					self?.courseView.stopLoading()
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
