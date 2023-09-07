//
//  CourseReviewTableViewCell.swift
//  honeycourses
//
//  Created by pagh on 2023/08/25.
//

import UIKit

final class CourseReviewTableViewCell: UITableViewCell {
	
	static let identifier = "CourseReviewTableViewCell"
	
	let containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let subTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let contentLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let gradeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let pointView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = 6
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	let pointLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let pointUpButton: UIButton = {
		let button = UIButton()
		button.setTitle("추천", for: .normal)
		button.setTitleColor(.label, for: .normal)
		return button
	}()
	
	let pointDownButton: UIButton = {
		let button = UIButton()
		button.setTitle("비추천", for: .normal)
		button.setTitleColor(.label, for: .normal)
		return button
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
		[pointUpButton, pointLabel, pointDownButton].forEach {
			pointView.addArrangedSubview($0)
		}
		[titleLabel, subTitleLabel, contentLabel, gradeLabel, pointView].forEach {
			containerView.addSubview($0)
		}
		self.contentView.addSubview(containerView)
	}
	
	private func activateConstraints() {
		[containerViewConstraints(),
		 titleLabelConstraints(),
		 subTitleLabelConstraints(),
		 contentLabelConstraints(),
		 gradeLabelConstraints(),
		 pointViewConstraints()].forEach {
			NSLayoutConstraint.activate($0)
		}
	}
	
	private func containerViewConstraints() -> [NSLayoutConstraint] {
		return [
			containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
		]
	}
	
	private func titleLabelConstraints() -> [NSLayoutConstraint] {
		return [
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
		]
	}
	
	private func subTitleLabelConstraints() -> [NSLayoutConstraint] {
		return [
			subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
		]
	}
	
	private func contentLabelConstraints() -> [NSLayoutConstraint] {
		return [
			contentLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 8),
			contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
		]
	}
	
	private func gradeLabelConstraints() -> [NSLayoutConstraint] {
		return [
			gradeLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
			gradeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			gradeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
		]
	}
	
	private func pointViewConstraints() -> [NSLayoutConstraint] {
		return [
			pointView.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 8),
			pointView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			pointView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
		]
	}
	
	
	func bind(_ courseReview: CourseReview) {
		titleLabel.text = courseReview.attributes.title
		subTitleLabel.text = "수강학기: \(courseReview.attributes.semester), 교수: \(courseReview.attributes.instructorName)"
//		contentLabel.attributedText = courseReview.content.htmlAttributedString()
		contentLabel.text = courseReview.content.replacingOccurrences(of: "<br>", with: "\n")
		gradeLabel.text = courseReview.attributes.grade
		pointLabel.text = "\(courseReview.point)"
	}
	
}

extension String {
	func htmlAttributedString() -> NSAttributedString? {
		guard let data = self.data(using: .utf8) else {
			return nil
		}
		
		return try? NSAttributedString(
			data: data,
			options: [
				.documentType: NSAttributedString.DocumentType.html,
				.characterEncoding: String.Encoding.utf8.rawValue
			],
			documentAttributes: nil
		)
	}
}
