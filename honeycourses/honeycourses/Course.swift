//
//  Course.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

import Foundation

struct Course {
	let id: Int
	let name: String
	let category: CourseCategory
	let isYouguan: Bool
	let credit: Int
	let department: String
}

typealias Courses = [Course]

extension Courses {
	func filtered(by courseListCategory: CourseListCategory) -> Self {
		return self.filter {
			if courseListCategory == .china {
				return $0.isYouguan
			} else if courseListCategory == .all {
				return true
			}
			return $0.category.title == courseListCategory.title
		}
	}
}
