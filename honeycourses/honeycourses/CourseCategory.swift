//
//  CourseListCategory.swift
//  honeycourses
//
//  Created by pagh on 2023/08/16.
//

enum CourseCategory: CaseIterable, Codable {
	case elective
	case sports
	case major
	case english
	case open
	case liberalArts
	case board
	
	var title: String {
		switch self {
		case .elective: return "通选课"
		case .sports: return "体育课"
		case .major: return "专业课"
		case .english: return "英语课"
		case .open: return "公选课"
		case .liberalArts: return "文科生必修"
		case .board: return "게시판"
		}
	}
}
