//
//  TokenServiceStub.swift
//  honeycoursesTests
//
//  Created by pagh on 2023/08/19.
//

@testable import honeycourses

final class TokenServiceStub: TokenService {
	
	func accessToken() async -> String? {
		return "dummyAccessToken"
	}
	
	func idToken() async -> String? {
		return "dummyIDToken"
	}
	
	func refreshToken() async -> String? {
		return "dummyRefreshToken"
	}
	
}

