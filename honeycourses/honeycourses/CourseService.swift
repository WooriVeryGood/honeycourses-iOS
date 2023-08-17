//
//  CourseService.swift
//  honeycourses
//
//  Created by pagh on 2023/08/17.
//

import Foundation

protocol CourseService {
	func requestList(completionHandler: @escaping (Result<String, NetworkError>) -> Void)
}

final class CourseServiceImplement: CourseService {
	
	private let networkManager: NetworkManger
	
	init(networkManager: NetworkManger) {
		self.networkManager = networkManager
	}
	
	func requestList(completionHandler: @escaping (Result<String, NetworkError>) -> Void) {
		networkManager.performRequest(queryString: "/courses") { result in
			switch result {
			case .success(let data):
				guard let dataString = String(data: data, encoding: .utf8)
				else {
					completionHandler(.failure(.parseError))
					return
				}
				completionHandler(.success(dataString))
			case .failure(let error):
				completionHandler(.failure(error))
			}
		}
	}
}
