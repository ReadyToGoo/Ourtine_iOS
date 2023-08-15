//
//  Ourtine MOYA.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation
import Moya

enum AuthAPI {
    
    /// 최종 회원가입
    /// - RequestBody :
    ///     - JSON : SignUpInfo : 회원가입 내용 구조체
    case postSignUp(info: SignUpInfo)
    
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.hyobn.shop/api")!
    }
    
    var path: String {
        switch self {
            
        case .postSignUp :
            return "/user/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .postSignUp :
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
   
        case .postSignUp(let info) :
            return .requestJSONEncodable(info)
        
        }
    }
    
    var headers: [String : String]? {
//        return ["Content-Type" : "application/json"]
//        return ["Authorization": "Bearer YOUR_ACCESS_TOKEN"]
        return .none
    }
}



