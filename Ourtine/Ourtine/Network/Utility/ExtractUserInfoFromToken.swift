//
//  ExtractUserInfoFromToken.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/15.
//

import Foundation
import SwiftJWT

/// 토큰의 페이로드에서 유저 정보를 추출하는 함수입니다.
/// token 인자엔, 앞부분이 제거된 토큰의 본문내용(페이로드)만이 들어가야 합니다
/// 성공적으로 진행된 경우, (myID, mySignUpStatus, Expiration) 를 튜플 형식으로 반환합니다.
func extractUserInfo(from token:String?) -> (String, String, Date)? {
    do {
        let jwt = try JWT<tokenStruct>(jwtString: token!, verifier: jwtVerifier)
        print(jwt.claims) // 디코드된 토큰의 페이로드를 출력합니다.
        
        // exp 값을 Date로 변환
        let expirationDate = Date(timeIntervalSince1970: TimeInterval(jwt.claims.exp))
        
        return(jwt.claims.username, jwt.claims.userStatus, expirationDate)
        
    } catch let error {
        print("Error decoding JWT: \(error)")
        return nil
    }
}
