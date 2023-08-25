//
//  SignUpInfoModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/17.
//

import Foundation

/// 가입 정보 최상위 구조체입니다
struct CreatingSignUpInfo {
    var nickName: String?
    var habitCategory: [String]?
    var resolutionString: String?
    var agreeList = AgreeList()

    /// 동의 내역 구조체입니다.
    struct AgreeList {
        var privacyAgreed: Bool?
        var termsAgreed: Bool?
        var marketingAgreed: Bool?
    }
}
