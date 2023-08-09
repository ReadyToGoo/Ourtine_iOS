//
//  FlowDataManager.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/10.
//

import Foundation
import UIKit

class SignUpFlowManager {
    static let shared = SignUpFlowManager()
    
    
}


/// 습관 개설 플로우에서 생성되는 데이터를 저장하는 싱글톤 클래스입니다.
class HabitCreateFlowManager {
    static let shared = HabitCreateFlowManager()
    
    /// 습관 정보 구조체입니다
    var habitInformation: HabitInfo?
    
    /// 습관 정보 최상위 구조체입니다
    struct HabitInfo {
        var habitType: HabitType?
        var habitCategory: [String]?
        var habitIntroduction: HabitIntroduction?
        
        /// 습관 소개 구조체입니다
        struct HabitIntroduction {
            var title: String?
            var hashtag: String?
            var image: UIImage?
            var description: String?
        }
        
        var habitTime: HabitTime?
        
        /// 습관 시간 구조체입니다
        struct HabitTime {
            var startTime: Date?
            var endTime: Date?
            var days: [String]?
        }
        
        var habitDate: HabitDate?
        
        /// 습관 날짜 구조체입니다
        struct HabitDate {
            var startDate: Date?
            var endDate: Date?
        }
        
        var habitMemberNum: Int?
    }
    
    /// 구조체 초기화 함수 입니다. 구조체 내의 모든 구조체 내의 내용이 nil로 초기화됩니다.
    func resetAll() {
        habitInformation?.reset()
    }
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


extension HabitCreateFlowManager.HabitInfo {
    /// 구조체 초기화 함수 입니다.
     mutating func reset() {
        habitType = nil
        habitCategory = nil
        habitIntroduction?.reset()
        habitTime?.reset()
        habitDate?.reset()
        habitMemberNum = nil
    }
}

extension HabitCreateFlowManager.HabitInfo.HabitIntroduction {
    /// 구조체 초기화 함수 입니다.
     mutating func reset() {
        title = nil
        hashtag = nil
        image = nil
        description = nil
    }
}

extension HabitCreateFlowManager.HabitInfo.HabitTime {
    /// 구조체 초기화 함수 입니다.
     mutating func reset() {
        startTime = nil
        endTime = nil
        days = nil
    }
}

extension HabitCreateFlowManager.HabitInfo.HabitDate {
    /// 구조체 초기화 함수 입니다.
    mutating func reset() {
        startDate = nil
        endDate = nil
    }
}
