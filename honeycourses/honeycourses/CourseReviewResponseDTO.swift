//
//  CourseReviewResponseDTO.swift
//  honeycourses
//
//  Created by pagh on 2023/08/25.
//

import Foundation

struct CourseReviewResponseDTO: Codable {
	let id: Int
	let courseID: Int
	let title: String
	let semester: String
	let instructorName: String
	let content: String
	let grade: String
	let point: Int
	
	enum CodingKeys: String, CodingKey {
		case id = "review_id"
		case courseID = "course_id"
		case title = "review_title"
		case semester = "taken_semyr"
		case instructorName = "instructor_name"
		case content = "review_content"
		case grade = "grade"
		case point = "review_point"
	}
}

extension CourseReviewResponseDTO {
	func toDomain() -> CourseReview {
		return .init(
			id: .init(reviewId: id, courseID: courseID),
			attributes: .init(
				title: title,
				instructorName: instructorName,
				semester: semester,
				grade: grade
			),
			content: content,
			point: point
		)
	}
}
