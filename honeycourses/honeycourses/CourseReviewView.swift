//
//  CourseReviewView.swift
//  honeycourses
//
//  Created by pagh on 2023/08/25.
//

import UIKit

final class CourseReviewView: BaseView<CourseReviewViewController> {
	
	let tableView: UITableView = {
		let tableView = UITableView()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	var isLoading: Bool {
		get {
			tableView.refreshControl?.isRefreshing ?? true
		}
	}
	
	override func setupUI() {
		self.backgroundColor = .white
		setupTableView()
	}
	
	override func setupBinding() {
		tableView.delegate = controller
		tableView.dataSource = controller
		
		tableView.register(CourseReviewTableViewCell.self, forCellReuseIdentifier: CourseReviewTableViewCell.identifier)
		
		tableView.refreshControl?.addTarget(
			controller,
			action: #selector(controller?.loadData),
			for: .valueChanged
		)
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
		if !isLoading {
			// TODO: TableViewCell 스켈레톤
		}
	}
	
	func stopLoading() {
		if isLoading {
			tableView.refreshControl?.endRefreshing()
			tableView.reloadData()
		}
	}
	
}
