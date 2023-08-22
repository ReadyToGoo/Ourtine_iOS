//
//  Struct.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/07.
//

// MARK: - HabitAPI에서 수신할 때 사용되는 struct입니다.
// MARK: - 이름 : "data_" 뒤에, request 케이스들의 이름과 동일한 이름이 붙습니다.

struct data_patchHabitProfileImage: Codable {
    let habitId: Int
}

/// 습관 개설하기 POST 구조체
struct data_postCreateHabit: Codable {
    let habitNum: Int
    let id: Int
}

/// 습관 프로필 GET 구조체
struct data_getHabitProfile: Codable {
    let following: Following
    let isFollowing: Bool
    let notFollowing: NotFollowing
    
    struct FollowerList: Codable {
        let id: Int
        let imageUrl, nickname: String?
    }
    
    struct Following: Codable {
        let category, detail: String
        let followerList: [FollowerList]
        let hashtags: [String]
        let hostId, id: Int
        let imageUrl: String?
        let participateRate: Int
        let title: String
    }
    
    struct NotFollowing: Codable {
        let category: String
        let days: [String]
        let detail, endDate, endTime: String
        let followerCount, followerLimit: Int
        let followerList: [FollowerList]
        let hashtags: [String]
        let hostId, id: Int
        let imageUrl: String?
        let isRecruiting: Bool
        let participateRate: Int
        let starRate: StarRate
        let startDate, startTime, title: String
        
        struct StarRate: Codable {
            let negativeZero: Bool
        }
        
    }
}

/// 습관 참여 POST 구조체
struct data_postParticipateHabit: Codable {
    let habitId, userId: Int
}

/// 습관 참여 취소 DELETE 구조체
struct data_deleteCancelHabit: Codable {
    let habitId, userId: Int
}

/// 습관 삭제 DELETE 구조체
struct data_deleteHabit: Codable {
    let habitId: Int
    let userId: Int
}

/// 습관 프로필의 위클리 로그 GET 구조체
struct data_getSingleHabitWeeklyLog: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let date: Int
        let emotion: String
    }
}

/// 참여 습관 추천 목록 GET 구조체
struct data_getDiscoverHabit: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let category: String
        let days: [String]
        let endTime: String
        let hostId: Int
        let hostImageUrl, hostName: String?
        let id: Int
        let imageUrl, startTime, title: String?
    }
}

/// 나를 팔로우한 유저의 습관 목록 조회 GET 구조체
struct data_getFollowedUserHabit: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let category: String
        let hashtags: [String]
        let id: Int
        let imageUrl, title: String?
    }
}

/// 내가 팔로우한 유저의 습관 목록 조회 GET 구조체
struct data_getFollowingUserHabit: Codable {
    let commonHabits, habits: Habits
    let isFriend: Bool
    let otherHabits: Habits
    let userId: Int
    
    struct Habits: Codable {
        let content: [Content]
        let first, hasNext, last: Bool
    }
    
    struct Content: Codable {
        let id: Int
        let imageUrl: String?
        let participateRate: Int
        let title: String
    }
}

/// /// 유저들에게 습관 초대장 보내기 POST 구조체
struct data_postHabitInvitation: Codable {
    let habitId: Int
}


/// 오늘 유저의 습관 GET 구조체
struct data_getTodaysHabit: Codable {
    let others, today: [Other]
    let userWeeklyLogContents, userWeeklyLogPeriod: String
    
    struct Other: Codable {
        let endTime: String
        let habitId: Int
        let imageUrl: String?
        let mvpCount, participationRate: Int
        let startTime, status, title: String
    }
}

/// 마이페이지 습관 기록 GET
struct data_getMyPageWeeklyLogs: Codable {
    let day, emotion, videoUrl: String
}

/// 참여 습관 추천 목록 GET 구조체
struct data_getRecommendedHabit: Codable {
    let content : [content]
    let hasNext : Bool
    let first : Bool
    let last : Bool
    
    struct content: Codable {
        let id: Int
        let hostId: Int
        let hostName: String
        let hostImageUrl: String?
        let title: String
        let imageUrl: String?
        let category: String
        let days: [String]
        let startTime: [Int]
        let endTime: [Int]
    }
}

/// 습관 검색 GET 구조체
struct data_getSearchHabit: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {   
        let category: String?
        let days: [String]?
        let endTime: String?
        let followerCount, followerLimit, hostId: Int?
        let hostImageUrl, hostName: String?
        let id: Int?
        let imageUrl, startTime, title: String?
    }

}
