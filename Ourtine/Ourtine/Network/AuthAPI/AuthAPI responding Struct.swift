//
//  AuthAPI responding Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/17.
//

import Foundation

// MARK: - AuthAPI에서 수신할 때 사용되는 struct입니다.

struct data_postSignUp: Codable {
    let nickname: String
}
