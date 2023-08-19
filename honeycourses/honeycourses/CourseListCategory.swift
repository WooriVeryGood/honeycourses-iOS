//
//  CourseListCategory.swift
//  honeycourses
//
//  Created by pagh on 2023/08/19.
//

enum CourseListCategory: CaseIterable {
	case all
	case elective
	case sports
	case major
	case open
	case english
	case china
	
	var title: String {
		switch self {
		case .all: return "All"
		case .elective: return "通选"
		case .sports: return "体育"
		case .major: return "专业"
		case .open: return "公选"
		case .english: return "英语"
		case .china: return "中国有关"
		}
	}
}
