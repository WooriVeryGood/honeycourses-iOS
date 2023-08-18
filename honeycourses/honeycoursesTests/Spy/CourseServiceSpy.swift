//
//  CourseServiceSpy.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import Foundation
@testable import honeycourses

final class CourseServiceSpy: CourseService {
	
	var token: String?
	var urlString: String?
	
	func requestList(token: String) async -> String? {
		urlString = "https://api.honeycourses.com/courses"
		self.token = token
		return nil
	}
	
}
