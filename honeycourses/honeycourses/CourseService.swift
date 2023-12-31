//
//  CourseService.swift
//  honeycourses
//
//  Created by pagh on 2023/08/17.
//

import Foundation

protocol CourseService {
	@discardableResult
	func requestCourses(token: String) async -> Courses?
}
