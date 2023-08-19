//
//  CourseDTO.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

import Foundation

struct CourseDTO: Codable {
	let id: Int
	let name: String
	let credit: Int
	let category: CourseCategory
	let isYouguan: Int
	let department: String
	
	enum CodingKeys: String, CodingKey {
		case id = "course_id"
		case name = "course_name"
		case credit = "course_credit"
		case category = "course_category"
		case isYouguan
		case department = "kaikeYuanxi"
	}
}

extension CourseDTO {
	func toDomain() -> Course {
		return .init(
			id: id,
			name: name,
			category: category,
			isYouguan: (isYouguan != 0),
			credit: credit,
			department: department
		)
	}
}
