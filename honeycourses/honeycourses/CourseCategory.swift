//
//  CourseListCategory.swift
//  honeycourses
//
//  Created by pagh on 2023/08/16.
//

enum CourseCategory: String, CaseIterable, Codable {
	case elective = "通选课"
	case sports = "体育课"
	case major = "专业课"
	case open = "公选课"
	case english = "英语课"
	case liberalArts = "文科生必修"
	case board = "게시판"
	
	var title: String {
		switch self {
		case .elective: return "通选"
		case .sports: return "体育"
		case .major: return "专业"
		case .open: return "公选"
		case .english: return "英语"
		case .liberalArts: return "文科生必修"
		case .board: return "게시판"
		}
	}
}
