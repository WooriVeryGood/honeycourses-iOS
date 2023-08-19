//
//  AuthManager.swift
//  honeycourses
//
//  Created by pagh on 2023/08/18.
//

protocol AuthService {
	func signUp(with signUpInfo: SignUpInfo) async -> Bool
	func signIn(with userSignInfo: UserSignInfo) async -> Bool
	func signOut() async -> Bool
}

struct UserSignInfo {
	let username: String
	let password: String
}

struct SignUpInfo {
	let userSignInfo: UserSignInfo
	let email: String
}
