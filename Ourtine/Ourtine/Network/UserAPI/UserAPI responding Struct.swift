//
//  UserAPI responding Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation

// MARK: - UserAPI에서 수신할 때 사용되는 struct입니다.
// MARK: - 이름 : "data_" 뒤에, request 케이스들의 이름과 동일한 이름이 붙습니다.


struct data_getUserProfile: Codable {
    let followerCount: Int
    let following: Bool
    let followingCount: Int
    let goal: String
    let habitCount: Int
    let imageUrl, nickname: String
    let participationRate: Int
    let userCategoryList: [String]
}

struct data_getPushNotiSettings: Codable {
    let marketingPushAlert, pushAlert: Bool
}

struct data_patchInterestingCategories: Codable {
    let userId: Int
}

struct data_patchMyGoal: Codable {
    let userId: Int
}

struct data_patchMarketingPushNotiSetting: Codable {
    let userId: Int
}

struct data_getMyPageInfo: Codable {
    let followerCount, followingCount: Int
    let goal: String
    let habitCount: Int
    let imageUrl, nickname: String
    let participationRate: Int
    let weeklyLog: [WeeklyLog]
    
    struct WeeklyLog: Codable {
        let day, emotion, videoUrl: String
    }
}

struct data_patchMyNickname: Codable {
    let userId: Int
}

struct data_patchMyProfileImage: Codable {
    let userId: Int
}

struct data_getSearchUserNickName: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let nickname, profileImage: String?
        let userId: Int?
    }
}


