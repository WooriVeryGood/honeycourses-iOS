//
//  NetworkError.swift
//  honeycourses
//
//  Created by pagh on 2023/08/17.
//

import Foundation

enum NetworkError: Error {
	case urlError
	case networkError
	case dataError
	case parseError
}
