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
	func requestList(token: String) async -> String? {
		guard let data = await networkService.request(queryString: "/courses", token: token)
		else { return nil }
		
		return String(data: data, encoding: .utf8)
	}
	
}
