//
//  FollowAPI responding Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation

// MARK: - FollowAPI에서 수신할 때 사용되는 struct입니다.
// MARK: - 이름 : "data_" 뒤에, request 케이스들의 이름과 동일한 이름이 붙습니다.

struct data_postFollowUser: Codable {
    let userId: Int
}

struct data_deleteUnfollowUser: Codable {
    let userId: Int
}

struct data_getMyFollwersList: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let nickname, profileImage: String
        let userId: Int
    }
}

struct data_getUserFollwersList: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let nickname, profileImage: String
        let userId: Int
    }
}

struct data_getMyFollowingsList: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let nickname, profileImage: String
        let userId: Int
    }
}

struct data_getUserFollowingList: Codable {
    let content: [Content]
    let first, hasNext, last: Bool
    
    struct Content: Codable {
        let nickname, profileImage: String
        let userId: Int
    }
}
