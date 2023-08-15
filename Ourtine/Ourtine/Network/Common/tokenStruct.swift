//
//  tokenStruct.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/08.
//

import Foundation
import SwiftJWT


struct tokenStruct: Claims {
    var username: String
    var auth: String
    var userStatus: String
    var iat: Int
    var exp: Int

    let iss: String? // Issuer
    let sub: String? // Subject
}


