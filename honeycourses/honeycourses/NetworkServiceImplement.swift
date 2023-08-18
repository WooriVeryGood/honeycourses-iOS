//
//  NetworkServiceImplement.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

import Foundation

final class NetworkServiceImplement: NetworkService {

	static let shared = NetworkServiceImplement()
	
	private let baseURL = "https://api.honeycourses.com"

	private init() { }

	func request(queryString: String, token: String) async -> Data? {
		guard let url = url(queryString: queryString) else { return nil }
		guard let (data, _) = try? await URLSession.shared.data(for: urlRequest(url: url, token: token))
		else {
			print("Network error")
			return nil
		}
		return data
	}
	
	private func url(queryString: String) -> URL? {
		if let url = URL(string: "\(baseURL)\(queryString)") {
			return url
		}
		print("URL error")
		return nil
	}
	
	private func urlRequest(url: URL, token: String) -> URLRequest {
		var request = URLRequest(url: url)
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		return request
	}

}
