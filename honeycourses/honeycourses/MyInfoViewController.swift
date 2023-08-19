//
//  MyInfoViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class MyInfoViewController: BaseViewController {
	
	private lazy var myInfoView = MyInfoView(controller: self)
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		self.view = myInfoView
	}
	
}
