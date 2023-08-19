//
//  CourseView.swift
//  honeycourses
//
//  Created by pagh on 2023/08/15.
//

import UIKit

@MainActor
final class CourseView: BaseView<CourseViewController> {
	
	private var currentCourseListCategory = CourseListCategory.all
	
	private lazy var courseListCategoryLabel: UILabel = {
		let label = UILabel()
		label.text = currentCourseListCategory.title
		return label
	}()
	
	private let searchController: UISearchController = {
		let searchController = UISearchController()
		searchController.searchBar.placeholder = "수업을 검색하세요"
		return searchController
	}()
	
	private let _tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	var tableView: UITableView {
		get { _tableView }
	}
	
	override func setupUI() {
		self.backgroundColor = .white
		setupLeftBarButtonItem()
		setupRightBarButtonItem()
		setupSearchController()
		setupTableView()
	}
	
	override func setupBinding() {
		tableView.delegate = controller
		tableView.dataSource = controller
		
		tableView.refreshControl?.addTarget(
			controller,
			action: #selector(controller?.loadData),
			for: .valueChanged
		)
	}
	
	private func setupLeftBarButtonItem() {
		let itemView = leftBarButtonItemView()
		let button = leftBarButtonItemCustomView(itemView: itemView)
		button.menu = courseListCategoryMenu()
		button.showsMenuAsPrimaryAction = true
		controller?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
	}
	
	private func setupRightBarButtonItem() {
		let buttonItem = UIBarButtonItem(
			title: "수업 추가",
			style: .plain,
			target: controller,
			action: #selector(controller?.addCourseButtonDidTap)
		)
		buttonItem.tintColor = .label
		controller?.navigationItem.rightBarButtonItem = buttonItem
	}
	
	private func setupSearchController() {
		controller?.navigationItem.searchController = searchController
	}
	
	private func setupTableView() {
		self.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		])
		
		tableView.refreshControl = UIRefreshControl()
	}
	
	func startLoading() {
		// TODO: TableViewCell 스켈레톤
	}
	
	func stopLoading() {
		tableView.refreshControl?.endRefreshing()
		tableView.reloadData()
	}
	
}

extension CourseView {
	private func courseListCategoryMenu() -> UIMenu {
		let actions = CourseListCategory.allCases.map { courseListCategory in
			UIAction(title: courseListCategory.title) { _ in
				self.changeCurrentListCourseCategory(courseListCategory)
			}
		}
		return UIMenu(children: actions)
	}
	
	private func leftBarButtonItemView() -> UIStackView {
		let stackView = containerStackView()
		let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
		imageView.tintColor = .label
		[courseListCategoryLabel, imageView].forEach {
			stackView.addArrangedSubview($0)
		}
		return stackView
	}
	
	private func containerStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = 6
		return stackView
	}
	
	private func leftBarButtonItemCustomView(itemView: UIView) -> UIButton {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		itemView.translatesAutoresizingMaskIntoConstraints = false
		button.addSubview(itemView)
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
			button.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
			button.topAnchor.constraint(equalTo: itemView.topAnchor),
			button.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)
		])
		return button
	}
	
	private func changeCurrentListCourseCategory(_ courseListCategory: CourseListCategory) {
		currentCourseListCategory = courseListCategory
		courseListCategoryLabel.text = courseListCategory.title
		controller?.courseListCategoryMenuDidTap(courseListCategory)
	}
}
