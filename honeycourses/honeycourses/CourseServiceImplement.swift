//
//  CourseServiceImplement.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

import Foundation

final class CourseServiceImplement: CourseService {
	
	private let networkService: NetworkService
	
	init(networkService: NetworkService) {
		self.networkService = networkService
	}
	
	@discardableResult
	func requestCourses(token: String) async -> Courses? {
		guard let data = await networkService.request(queryString: "/courses", token: token)
		else { return nil }
		
		return try? JSONDecoder().decode([CourseDTO].self, from: data).map { $0.toDomain() }
	}
	
}
