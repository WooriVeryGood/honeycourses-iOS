//
//  TabBarController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

class TabBarController: UITabBarController {
	
	private let reviewViewController: ReviewViewController = {
		let reviewViewController = ReviewViewController()
		reviewViewController.title = "수업 리뷰"
		reviewViewController.tabBarItem.image = UIImage(systemName: "books.vertical")
		return reviewViewController
	}()
	
	private let communityViewController: CommunityViewController = {
		let communityViewController = CommunityViewController()
		communityViewController.title = "커뮤니티"
		communityViewController.tabBarItem.image = UIImage(systemName: "message")
		return communityViewController
	}()
	
	private let myInfoViewController: MyInfoViewController = {
		let myInfoViewController = MyInfoViewController()
		myInfoViewController.title = "내 정보"
		myInfoViewController.tabBarItem.image = UIImage(systemName: "person")
		return myInfoViewController
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
	}
	
	private func configure() {
		let reviewNavigationController = UINavigationController(rootViewController: reviewViewController)
		let communityNavigationController = UINavigationController(rootViewController: communityViewController)
		let myInfoNavigationController = UINavigationController(rootViewController: myInfoViewController)
		
		self.setViewControllers([
			reviewNavigationController,
			communityNavigationController,
			myInfoNavigationController
		], animated: false)
	}
	
}
