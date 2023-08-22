//
//  AuthAPI sending Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/15.
//

import Foundation

// MARK: - AuthAPI에서 송신할 때 사용되는 struct입니다.

struct SignUpInfo: Encodable {
    let favoriteCategoryList: [String]
    let goal: String
    let marketingAgreed: Bool
    let nickname: String
    let privacyAgreed, termsAgreed: Bool
}
