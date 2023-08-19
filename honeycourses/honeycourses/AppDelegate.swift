//
//  AppDelegate.swift
//  honeycourses
//
//  Created by pagh on 2023/08/14.
//

import UIKit

import Amplify
import AWSCognitoAuthPlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		do {
			try Amplify.add(plugin: AWSCognitoAuthPlugin())
			try Amplify.configure()
			print("Amplify configured with auth plugin")
		} catch {
			print("An error occurred setting up Amplify: \(error)")
		}
		
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}


}

