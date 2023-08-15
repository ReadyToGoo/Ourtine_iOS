//
//  ExtractTokenFromCookie.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/15.
//

import Foundation

/// 서버에서 받아온 쿠키형식의 토큰을 리파인하는 함수입니다.
/// 앞부분이 제거된 본문의 내용만 String으로 반환합니다.
func extractTokenPrefix(from token: String) -> String? {
    let targetPrefix = "Authorization=Bearer%20"
    
    if token.hasPrefix(targetPrefix) {
        // "Authorization=Bearer%20" 부분을 제거한 토큰 반환
        return String(token.dropFirst(targetPrefix.count))
    }
    
    return nil
}
