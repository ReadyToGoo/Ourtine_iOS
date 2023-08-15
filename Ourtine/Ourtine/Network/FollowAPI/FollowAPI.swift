//
//  FollowAPI.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation
import Moya

enum FollowAPI {
    
    /// 유저 팔로우하기 POST
    /// - RequestBody :
    ///     - JSON : userTarget : 상대 id 구조체
    case postFollowUser(target: userTarget)
    
    /// 유저 언팔로우하기 DELETE
    /// - RequestBody :
    ///     - JSON : userTarget : 상대 id 구조체
    case deleteUnfollowUser(target: userTarget)
    
    /// 내 팔로워 조회 GET
    case getMyFollwersList
    
    /// 특정 유저의 팔로워 조회 GET
    /// - PATH Parameters:
    ///     - user_id : int : 유저 id
    case getUserFollowersList(userId: Int)
    
    /// 내 팔로잉 조회 GET
    case getMyFollowingsList
    
    /// 특정 유저의 팔로잉 조회 GET
    /// - PATH Parameters:
    ///     - user_id : int : 유저 id
    case getUserFollowingsList(userId: Int)
    
}

extension FollowAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.hyobn.shop/follow")!
    }
    
    var path: String {
        switch self {
            
        case .postFollowUser, .deleteUnfollowUser :
            return ""
            
        case .getMyFollwersList :
            return("/followers/me")
            
        case .getUserFollowersList(let userId) :
            return("/followers/users/\(userId)")
            
        case .getMyFollowingsList :
            return("/followings/me")
            
        case .getUserFollowingsList(let userId) :
            return("/followings/users/\(userId)")
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postFollowUser :
            return .post
            
        case .deleteUnfollowUser :
            return .delete
            
        case .getMyFollwersList, .getUserFollowersList, .getMyFollowingsList, .getUserFollowingsList :
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postFollowUser(let target), .deleteUnfollowUser(let target) :
            return .requestJSONEncodable(target)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
    
}

