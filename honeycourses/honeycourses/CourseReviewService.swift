//
//  CourseReviewService.swift
//  honeycourses
//
//  Created by pagh on 2023/08/25.
//

import Foundation

protocol CourseReviewService {
	func requestCourseReviews(courseID: Int, token: String) async -> CourseReviews?
}

final class CourseReviewServiceImplement: CourseReviewService {
	
	private let networkService: NetworkService
	
	init(networkService: NetworkService) {
		self.networkService = networkService
	}
	
	func requestCourseReviews(courseID: Int, token: String) async -> CourseReviews? {
		guard let data = await networkService
			.request(queryString: "/courses/\(courseID)/reviews", token: token)
		else { return nil }
		
		return try? JSONDecoder()
			.decode([CourseReviewResponseDTO].self, from: data)
			.map { $0.toDomain() }
	}
	
}
