//
//  CourseServiceSpy.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

import Combine
@testable import honeycourses

final class CourseServiceSpy: CourseService {
	
	var token: String?
	var urlString: String?
	
	@Published private(set) var requestListIsCalled = false
	
	private let dummyCourses = [
		Course(id: 1, name: "计算机系统导论", category: .major, isYouguan: false, credit: 5, department: "信息科学技术学院"),
		Course(id: 2, name: "中国历史文选B（上）", category: .major, isYouguan: true, credit: 4, department: "历史学系"),
		Course(id: 3, name: "社会性别研究", category: .elective, isYouguan: false, credit: 2, department: "社会学系"),
	]
	
	func requestCourses(token: String) async -> Courses? {
		requestListIsCalled = true
		urlString = "https://api.honeycourses.com/courses"
		self.token = token
		return dummyCourses
	}
	
}
