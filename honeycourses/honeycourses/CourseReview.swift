//
//  CourseReview.swift
//  honeycourses
//
//  Created by pagh on 2023/08/25.
//

import Foundation

struct CourseReview {
	let id: ID
	let attributes: Attributes
	let content: String
	let point: Int
	
	struct ID {
		let reviewId: Int
		let courseID: Int
	}
	
	struct Attributes {
		let title: String
		let instructorName: String
		let semester: String
		let grade: String
	}
}

typealias CourseReviews = [CourseReview]
