//
//  HabitSessionAPI.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation
import Moya

enum HabitSessionAPI {
    
    /// 입장한 습관 세션 정보 조회 GET
    case getHabitSessionInfo(sessionId: Int)
    
    /// 입장한 습관 세션 베스트 습관러 조회 GET
    case getHabitSessionMVP(sessionId: Int)
    
    /// 습관 세션 회고 업로드 PATCH
    /// - RequestBody :
    ///     - JSON : habitReview : 회고 내용 구조체
    case patchUploadSessionReview(sessionId: Int, review: habitReview)
    
    /// 습관 세션 영상 업로드 PATCH
    /// - RequestBody :
    ///     - Binary String File : videoData
    ///     - videoData는 video파일에서 Data형태로 변환해준 후 넣어주셔야 합니다.
    case patchUploadSessionVideo(sessionId: Int, videoData: Data)
    
    /// 습관 세션 MVP 후보 조회 GET
    case getMVPCandidateList(sessionId: Int)
    
    /// 습관 세션 MVP 투표하기 PATCH
    /// - RequestBody :
    ///     - JSON : mvpVote : 투표 내용 구조체
    case patchMVPVote(sessionId: Int, vote: mvpVote)
    
    /// 습관 세션 ID 조회하기 GET
    case getHabitSessionID(habitId: Int)
    
    /// 습관 세션 입장하기 POST
    case postJoinHabitSession(habitId: Int)
}

extension HabitSessionAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.hyobn.shop/habit-sessions")!
    }
    
    var path: String {
        switch self {
        case .getHabitSessionInfo(let sessionId) :
            return "/\(sessionId)"
        
        case .getHabitSessionMVP(let sessionId) :
            return "/\(sessionId)/mvp"
            
        case .patchUploadSessionReview(let sessionId, _):
            return "/\(sessionId)/review"
            
        case .patchUploadSessionVideo(let sessionId, _) :
            return "/\(sessionId)/upload"
            
        case .getMVPCandidateList(let sessionId) :
            return "/\(sessionId)/vote"
            
        case .patchMVPVote(let sessionId, _) :
            return "/\(sessionId)/vote"
            
        case .getHabitSessionID(let habitId) :
            return "/\(habitId)/habit-sessions"
            
        case .postJoinHabitSession(let habitId) :
            return "/\(habitId)/habit-sessions"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHabitSessionID, .getHabitSessionMVP, .getHabitSessionInfo, .getMVPCandidateList :
            return .get
            
        case .patchMVPVote, .patchUploadSessionVideo, .patchUploadSessionReview :
            return .patch
            
        case .postJoinHabitSession :
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchUploadSessionReview(_, let review) :
            return .requestJSONEncodable(review)
            
        case .patchUploadSessionVideo(_, let videoData) :
            let formData = MultipartFormData(provider: .data(videoData), name: "video", fileName: "video.mp4", mimeType: "video/mp4")
            return .uploadMultipart([formData])
            
        case .patchMVPVote(_, let vote) :
            return .requestJSONEncodable(vote)
            
        default :
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
    
    
}
