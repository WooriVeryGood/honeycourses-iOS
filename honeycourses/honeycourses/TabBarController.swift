//
//  TabBarController.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

final class TabBarController: UITabBarController {
	
	private let courseViewController: CourseViewController = {
		let courseViewController = CourseViewController()
		courseViewController.title = "수업 리뷰"
		courseViewController.tabBarItem.image = UIImage(systemName: "books.vertical")
		return courseViewController
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
		let courseNavigationController = UINavigationController(rootViewController: courseViewController)
		let communityNavigationController = UINavigationController(rootViewController: communityViewController)
		let myInfoNavigationController = UINavigationController(rootViewController: myInfoViewController)
		
		setupViewControllers([
			courseNavigationController,
			communityNavigationController,
			myInfoNavigationController
		])
	}
	
	private func setupViewControllers(_ viewControllers: [UIViewController]) {
		self.setViewControllers(viewControllers, animated: false)
	}
	
}
