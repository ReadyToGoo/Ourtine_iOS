//
//  Ourtine MOYA.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation
import Moya

enum UserAPI {
    
    /// 특정 유저 프로필 GET
    case getUserProfile(userId: Int)
    
    /// 유저의 푸쉬 알림, 마케팅 알람 설정 값  GET
    case getPushNotiSettings
    
    /// 관심 카테고리 변경 PATCH
    /// - RequestBody :
    ///     - Binary String File : categories : [String]
    case patchInterestingCategories(categories: [String])
    
    /// 다짐 변경 PATCH
    /// - RequestBody :
    ///     - JSON : MyGoal : 다짐 내용 구조체
    case patchMyGoal(goal: MyGoal)
    
    /// 유저 마케팅 푸쉬 알림 설정 변경 PATCH
    // MARK: - 이거 왜 전송하는 파라미터가 없죠? 서버 내 toggle임??
    case patchMarketingPushNotiSetting
    
    /// 마이페이지 정보 GET
    case getMyPageInfo
    
    /// 닉네임 변경 PATCH
    /// - RequestBody :
    ///     - JSON : MyGoal : 닉네임 변경 내용 구조체
    case patchMyNickname(nickname: MyNickname)
    
    /// 프로필 이미지 변경 PATCH
    /// - RequestBody :
    ///     - Binary String File : imageData
    ///     - 이미지 파일은 Data 형식으로 변환해서 넣어주셔야 합니다.
    ///     - ex) if let jpegData = image.jpegData(compressionQuality: 0.8)
    case patchMyProfileImage(imageData: Data)
    
    /// 유저 푸쉬 알림 설정 변경 PATCH
    // MARK: - 이거 왜 전송하는 파라미터가 없죠? 서버 내 toggle임??
    case patchPushNotiSetting
    
    /// 유저 닉네임으로 프로필 검색 GET
    /// - Query Parameters:
    ///     - keyword : 검색 단어입니다.
    case getSearchUserNickName(keyword: String)
    
   
    
    
    
}

extension UserAPI : TargetType {
    var baseURL: URL {
        return URL(string: "https://api.hyobn.shop/user")!
    }
    
    var path: String {
        switch self {
            
        case .getUserProfile(let userId) :
            return "/\(userId)/profile"
            
        case .getPushNotiSettings :
            return "/alerts"
            
        case .patchInterestingCategories :
            return "/category"
            
        case .patchMyGoal :
            return "/goal"
            
        case .patchMarketingPushNotiSetting :
            return "/marketingPushAlert"
            
        case .getMyPageInfo :
            return "/myPage"
            
        case .patchMyNickname :
            return "/nickname"
            
        case .patchMyProfileImage :
            return "/profile"
            
        case .patchPushNotiSetting :
            return "/pushAlert"
        
        case .getSearchUserNickName :
            return "/search"
        
        
        
       
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile, .getMyPageInfo, .getSearchUserNickName, .getPushNotiSettings :
            return .get
        
        case .patchInterestingCategories, .patchMyGoal, .patchMarketingPushNotiSetting, .patchMyNickname, .patchMyProfileImage, .patchPushNotiSetting :
            return .patch
            
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchInterestingCategories(let categories):
            let arrayData: Data = try! JSONSerialization.data(withJSONObject: categories, options: [])
            return .requestData(arrayData)
            
        case .patchMyGoal(let goal) :
            return .requestJSONEncodable(goal)
            
        case .patchMyNickname(let nickname) :
            return .requestJSONEncodable(nickname)
            
        case .patchMyProfileImage(let imageData) :
            
            // 이미지 data를 멀티파트폼 데이터로 지정
            let image_formData = MultipartFormData(provider: .data(imageData), name: "image", fileName: "test.png", mimeType: "image/png")
            
            let formData: [MultipartFormData] = [
                image_formData
            ]
            
            return .uploadMultipart(formData)
            
        case .getSearchUserNickName(let keyword):
            let params = [
                "keyword" : keyword
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
          
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
}
