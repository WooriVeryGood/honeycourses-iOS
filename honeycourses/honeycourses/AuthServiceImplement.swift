//
//  AuthServiceImplement.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

import Amplify
import AWSCognitoAuthPlugin

final class AuthServiceImplement: AuthService {
	
	static let shared = AuthServiceImplement()
	
	private init() { }

	func signUp(with signUpInfo: SignUpInfo) async -> Bool {
		guard let result = await requestSignUpResult(with: signUpInfo)
		else {
			print("An error occurred while registering a user")
			return false
		}
		
		return checkSignUpResultValidation(result)
	}
	
	private func requestSignUpResult(with signUpInfo: SignUpInfo) async -> AuthSignUpResult? {
		let userAttributes = [AuthUserAttribute(.email, value: signUpInfo.email)]
		let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
		
		return try? await Amplify.Auth.signUp(
			username: signUpInfo.userSignInfo.username,
			password: signUpInfo.userSignInfo.password,
			options: options
		)
	}
	
	private func checkSignUpResultValidation(_ result: AuthSignUpResult) -> Bool {
		if case let .confirmUser(deliveryDetails, _, userId) = result.nextStep {
			print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
			return false
		}
		print("SignUp Complete")
		return true
	}
	
	func signIn(with userSignInfo: UserSignInfo) async -> Bool {
		if let signInResult = try? await Amplify.Auth.signIn(
			username: userSignInfo.username,
			password: userSignInfo.password
		) {
			return signInResult.isSignedIn
		}
		print("Sign in failed")
		return false
	}
	
	func signOut() async -> Bool {
		if let signOutResult = await Amplify.Auth.signOut() as? AWSCognitoSignOutResult {
			print("Local signout successful: \(signOutResult.signedOutLocally)")
			return checkSignOutResultValidation(signOutResult)
		}
		
		print("Signout failed")
		return false
	}
	
	private func checkSignOutResultValidation(_ result: AWSCognitoSignOutResult) -> Bool {
		switch result {
		case .complete:
			// Sign Out completed fully and without errors.
			print("Signed out successfully")
			return true
		case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
			// Sign Out completed with some errors. User is signed out of the device.
			handleSignOutResultPartialError((revokeTokenError, globalSignOutError, hostedUIError))
		case .failed(let error):
			// Sign Out failed with an exception, leaving the user signed in.
			print("SignOut failed with \(error)")
		}
		return false
	}
	
	private func handleSignOutResultPartialError(
		_ partial: (
			revokeTokenError: AWSCognitoRevokeTokenError?,
			globalSignOutError: AWSCognitoGlobalSignOutError?,
			hostedUIError: AWSCognitoHostedUIError?
		)
	) {
		if let hostedUIError = partial.hostedUIError {
			print("HostedUI error  \(String(describing: hostedUIError))")
		}
		if let globalSignOutError = partial.globalSignOutError {
			// Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
			print("GlobalSignOut error  \(String(describing: globalSignOutError))")
		}
		if let revokeTokenError = partial.revokeTokenError {
			// Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
			print("Revoke token error  \(String(describing: revokeTokenError))")
		}
	}
	
}
