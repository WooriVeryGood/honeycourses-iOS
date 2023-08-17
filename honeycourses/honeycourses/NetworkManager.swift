//
//  NetworkManager.swift
//  honeycourses
//
//  Created by pagh on 2023/08/17.
//

import Foundation

protocol NetworkManger {
	func performRequest(queryString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkManagerImplement: NetworkManger {

	static let shared = NetworkManagerImplement()
	
	private let baseURL = "https://api.honeycourses.com"

	private init() { }

	func performRequest(queryString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
		guard let url = URL(string: "\(baseURL)\(queryString)")
		else {
			completion(.failure(.urlError))
			return
		}

		let task = URLSession(configuration: .default)
			.dataTask(with: url) { data, urlResponse, error in
				if let _ = error {
					completion(.failure(.networkError))
					return
				}

				guard let data
				else {
					completion(.failure(.dataError))
					return
				}

				completion(.success(data))
			}
		task.resume()
	}

}
