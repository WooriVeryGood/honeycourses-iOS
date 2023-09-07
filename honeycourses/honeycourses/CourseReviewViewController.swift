//
//  CourseReviewViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/25.
//

import UIKit

class CourseReviewViewController: BaseViewController {
	
	lazy var courseReviewView = CourseReviewView(controller: self)
	
	var courseReviewService: CourseReviewService?
	var tokenService: TokenService?
	var courseID: Int?
	
	private(set) var courseReviews: CourseReviews?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		self.view = courseReviewView
	}
	
}

extension CourseReviewViewController {
	@objc func loadData() {
		courseReviewView.startLoading()
		
		Task {
			self.courseReviews = await requestCourseReviews()
			courseReviewView.stopLoading()
		}
	}
	
	private func requestCourseReviews() async -> CourseReviews {
		guard let token = await tokenService?.idToken() else { return [] }
		guard let courseID, let courseReivews = await courseReviewService?.requestCourseReviews(courseID: courseID, token: token)
		else { return [] }
		return courseReivews
	}
}

extension CourseReviewViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return courseReviews?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView
			.dequeueReusableCell(withIdentifier: CourseReviewTableViewCell.identifier) as? CourseReviewTableViewCell,
					let courseReviews
		else { return CourseReviewTableViewCell() }
		cell.bind(courseReviews[indexPath.row])
		return cell
	}
}
