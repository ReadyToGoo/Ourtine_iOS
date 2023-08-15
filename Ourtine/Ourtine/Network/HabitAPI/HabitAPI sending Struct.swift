//
//  HabitAPI Struct.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/13.
//

import Foundation

// MARK: - HabitAPI에서 송신할 때 사용되는 struct입니다.


/// HabitAPI의 .postCreateHabit에서 사용되는
/// 습관 개설 내용입니다.
struct habitCreationContent: Encodable {
    let category: String
    let days: [String]
    let detail, endDate, endTime: String
    let followerLimit: Int
    let habitStatus: String
    let hashtags: [String]
    let startDate, startTime, title: String
}


/// HabitAPI의 .postHabitInvitation에서 사용되는
/// 습관 초대장 구조체입니다.
struct invitationTarget: Encodable {
    var friends : [Int]
    var habitId : Int
}
