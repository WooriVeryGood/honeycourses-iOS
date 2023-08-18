//
//  TokenServiceImplement.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

import Amplify
import AWSPluginsCore

final class TokenServiceImplement: TokenService {
	
	static let shared = TokenServiceImplement()
	
	static private var authSession: AuthSession? {
		get async {
			if let authSession = try? await Amplify.Auth.fetchAuthSession() {
				return authSession
			}
			print("Fetch auth session failed")
			return nil
		}
	}
	
	enum Token {
		case access
		case id
		case refresh
	}
	
	private init() { }
	
	func accessToken() async -> String? {
		guard let authSession = await TokenServiceImplement.authSession else { return nil }
		return token(authSession: authSession, type: .access)
	}
	
	func idToken() async -> String? {
		guard let authSession = await TokenServiceImplement.authSession else { return nil }
		return token(authSession: authSession, type: .id)
	}
	
	func refreshToken() async -> String? {
		guard let authSession = await TokenServiceImplement.authSession else { return nil }
		return token(authSession: authSession, type: .refresh)
	}
	
	private func token(authSession: AuthSession, type: Token) -> String? {
		guard let cognitoTokenProvider = authSession as? AuthCognitoTokensProvider else { return nil }
		guard let tokens = try? cognitoTokenProvider.getCognitoTokens().get() else { return nil }
		switch type {
		case .access: return tokens.accessToken
		case .id: return tokens.idToken
		case .refresh: return tokens.refreshToken
		}
	}
	
}
