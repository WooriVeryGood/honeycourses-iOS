//
//  TokenService.swift
//  honeycourses
//
//  Created by pagh on 2023/08/18.
//

protocol TokenService {
	func accessToken() async -> String?
	func idToken() async -> String?
	func refreshToken() async -> String?
}
