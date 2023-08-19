//
//  NetworkService.swift
//  honeycourses
//
//  Created by pagh on 2023/08/17.
//

import Foundation

protocol NetworkService {
	func request(queryString: String, token: String) async -> Data?
}
