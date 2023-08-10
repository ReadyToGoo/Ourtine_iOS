//
//  HabitInfoModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/10.
//

import Foundation
import UIKit

/// 습관 정보 최상위 구조체입니다
struct HabitInfo {
    var habitType: HabitType?
    var habitCategory: [String]?
    var habitIntroduction = HabitIntroduction()
    
    /// 습관 소개 구조체입니다
    struct HabitIntroduction {
        var title: String?
        var hashtag: String?
        var image: UIImage?
        var description: String?
    }
    
    var habitTime = HabitTime()
    
    /// 습관 시간 구조체입니다
    struct HabitTime {
        var startTime: Date?
        var endTime: Date?
        var days: [String]?
    }
    
    var habitDate = HabitDate()
    
    /// 습관 날짜 구조체입니다
    struct HabitDate {
        var startDate: Date?
        var endDate: Date?
    }
    
    var habitMemberNum: Int?
    
    var habitMemberList: [String]?
}

/// 습관의 종류를 반환하는 enum입니다
enum HabitType {
    case privateType
    case publicType
    
    /// 각 타입의 문자열을 반환합니다.
    var stringValue: String {
            switch self {
            case .privateType:
                return "public"
            case .publicType:
                return "private"
            }
        }
}
