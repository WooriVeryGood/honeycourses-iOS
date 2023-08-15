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
	}
	
	override func loadView() {
		self.view = courseView
	}
	
}
