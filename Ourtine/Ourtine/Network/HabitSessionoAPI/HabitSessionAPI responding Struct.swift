//
//  HabitSessionAPI responding Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/15.
//

import Foundation

// MARK: - HabitSessionAPI에서 수신할 때 사용되는 struct입니다.
// MARK: - 이름 : "data_" 뒤에, request 케이스들의 이름과 동일한 이름이 붙습니다.

struct data_getHabitSessionInfo: Codable {
    let endTime: String
    let followers: [Follower]
    let habitId, hostId, sessionId: Int
    let startTime, title: String

    struct Follower: Codable {
        let habitFollowerStatus, imageUrl, nickname: String?
        let userId: Int
    }
}

struct data_getHabitSessionMVP: Codable {
    let imageUrl, nickname: String?
    let userId: Int
}

struct data_patchUploadSessionReview: Codable {
    let sessionId, userId: Int
}

struct data_patchUploadSessionVideo: Codable {
    let sessionId, userId: Int
}

struct data_getMVPCandidateList: Codable {
    let candidates: [Candidate]
    let sessionId: Int
    
    struct Candidate: Codable {
        let habitFollowerStatus: String
        let id: Int
        let videoUrl: String
    }
}

struct data_patchMVPVote: Codable {
    let mvpVote: Int
}

struct data_getHabitSessionID: Codable {
    let sessionId: Int
}

struct data_postJoinHabitSession: Codable {
    let followerId, habitId, sessionId: Int
}
