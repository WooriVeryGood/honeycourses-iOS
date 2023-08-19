//
//  CourseTableViewCell.swift
//  honeycourses
//
//  Created by pagh on 2023/08/20.
//

import UIKit

final class CourseTableViewCell: UITableViewCell {
	
	static let identifier = "CourseTableViewCell"
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let creditLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let categoryLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let departmentLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let youguanLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupUI() {
		addSubviews()
		activateConstraints()
	}
	
	private func addSubviews() {
		[nameLabel, creditLabel, categoryLabel, departmentLabel, youguanLabel].forEach {
			self.addSubview($0)
		}
	}
	
	private func activateConstraints() {
		[nameLabelConstraints(),
		 creditLabelConstraints(),
		 categoryLabelConstraints(),
		 departmentLabelConstraints(),
		 youguanLabelConstraints()].forEach {
			NSLayoutConstraint.activate($0)
		}
	}
	
	private func nameLabelConstraints() -> [NSLayoutConstraint] {
		return [
			nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
		]
	}
	
	private func creditLabelConstraints() -> [NSLayoutConstraint] {
		return [
			creditLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
			creditLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
		]
	}
	
	private func categoryLabelConstraints() -> [NSLayoutConstraint] {
		return [
			categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
			categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
			categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
		]
	}
	
	private func departmentLabelConstraints() -> [NSLayoutConstraint] {
		return [
			departmentLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
			departmentLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 8)
		]
	}
	
	private func youguanLabelConstraints() -> [NSLayoutConstraint] {
		return [
			youguanLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
			youguanLabel.leadingAnchor.constraint(equalTo: departmentLabel.trailingAnchor, constant: 8)
		]
	}
	
	
	func bind(_ course: Course) {
		nameLabel.text = course.name
		creditLabel.text = "\(course.credit)점"
		categoryLabel.text = course.category.title
		departmentLabel.text = course.department
		youguanLabel.isHidden = !course.isYouguan
		youguanLabel.text = course.isYouguan ? "中国有关" : ""
	}
	
}
