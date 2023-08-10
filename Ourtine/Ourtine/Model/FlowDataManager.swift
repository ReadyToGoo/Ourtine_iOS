//
//  FlowDataManager.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/10.
//

import Foundation

class SignUpFlowManager {
    static let shared = SignUpFlowManager()
    
    
}


/// 습관 개설 플로우에서 생성되는 데이터를 저장하는 싱글톤 클래스입니다.
class HabitCreateFlowManager {
    static let shared = HabitCreateFlowManager()
    

    /// 습관 정보 객체입니다
    var habitInformation = HabitInfo()
    
    /// 디버깅용
    func printself() {
        print(self.habitInformation)
    }
    
    /// 구조체 초기화 함수 입니다. 구조체 내의 모든 구조체 내의 내용이 nil로 초기화됩니다.
    func resetAll() {
        habitInformation.reset()
    }
}




extension HabitInfo {
    /// 구조체 초기화 함수 입니다.
     mutating func reset() {
        habitType = nil
        habitCategory = nil
        habitIntroduction.reset()
        habitTime.reset()
        habitDate.reset()
        habitMemberNum = nil
    }
}

extension HabitInfo.HabitIntroduction {
    /// 구조체 초기화 함수 입니다.
     mutating func reset() {
        title = nil
        hashtag = nil
        image = nil
        description = nil
    }
}

extension HabitInfo.HabitTime {
    /// 구조체 초기화 함수 입니다.
     mutating func reset() {
        startTime = nil
        endTime = nil
        days = nil
    }
}

extension HabitInfo.HabitDate {
    /// 구조체 초기화 함수 입니다.
    mutating func reset() {
        startDate = nil
        endDate = nil
    }
}
