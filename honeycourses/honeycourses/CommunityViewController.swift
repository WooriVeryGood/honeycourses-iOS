//
//  CommunityViewController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class CommunityViewController: BaseViewController {
	
	private lazy var communityView = CommunityView(controller: self)
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		self.view = communityView
	}
	
}
