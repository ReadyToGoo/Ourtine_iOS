//
//  JWTVerifier.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/15.
//

import Foundation
import SwiftJWT

// MARK: - 추후 gitignore에 추가해서 remote에서 제거되어야 합니다
let jwtVerifier = JWTVerifier.hs256(key: Data(base64Encoded: "7JWE7JuM7Yu0IO2UhOuhnOygne2KuCDtlZzrsogg7KCc64yA66GcIOunjOuTpOyWtOu0kOyalCDslYTsnpDslYTsnpAg7ZmU7J207YyFISEhISE=") ?? Data()) // HMAC-SHA-256
