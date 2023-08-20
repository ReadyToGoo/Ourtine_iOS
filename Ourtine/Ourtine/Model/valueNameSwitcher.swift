//
//  valueNameSwitcher.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/21.
//

import Foundation

/// 서버에서 온 영문 날짜를 한글 날짜로 맵핑하는 enum입니다.
enum DayOfWeek: String {
    case MON = "월"
    case TUE = "화"
    case WED = "수"
    case THU = "목"
    case FRI = "금"
    case SAT = "토"
    case SUN = "일"
    
    func toKoreanDay() -> String {
        return self.rawValue
    }
}

/// 서버에서 온 영문 날짜를 한글 날짜로 변환해주는 함수입니다.
func convertToKoreanDayNames(_ dayNames: [String]) -> [String] {
    var koreanDayNames: [String] = []
    
    for day in dayNames {
        if let enumValue = DayOfWeek(rawValue: day) {
            koreanDayNames.append(enumValue.toKoreanDay())
        } else {
            koreanDayNames.append(day)
        }
    }
    
    return koreanDayNames
}

// 01:35:00과 같이 반환되는 시간값을 0135으로 변환해주는 함수입니다.
func extractHourMinFromDateString(_ input: String) -> String {
    let numbers = input.filter { $0.isNumber }
    return String(numbers.prefix(4))
}

/// 서버에서 받아오는 카테고리 값에서 셀의 텍스트 내용으로 변환합니다.
func categoryValueFromResponseData(text: String) -> String {
    switch text {
    case "EXERCISE":
        return "운동"
    case "LIFESTYLE":
        return "생활습관"
    case "READING":
        return "독서"
    case "STUDY":
        return "스터디"
    case "LANGUAGE":
        return "외국어"
    case "HOBBY":
        return "취미생활"
    case "MONEY":
        return "돈관리"
    case "CAREER":
        return "커리어"
    default:
        return "noValue"
    }
}

/// 서버 송신 전, 한글 카테고리 내용을 영문으로 변환합니다.
func convertCategoryNameToEnglish(text: String) -> String {
    switch text {
    case "운동":
        return "EXERCISE"
    case "생활습관":
        return "LIFESTYLE"
    case "독서":
        return "READING"
    case "스터디":
        return "STUDY"
    case "외국어":
        return "LANGUAGE"
    case "취미생활":
        return "HOBBY"
    case "돈관리":
        return "MONEY"
    case "커리어":
        return "CAREER"
    default:
        return "noValue"
    }
}
