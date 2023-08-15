//
//  Base Responding Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation

/// Server's Base Response
struct Response<T:Codable>: Codable {
    let code: Int   // status code
    let isSuccess: Bool
    let message: String // description
    let result: T   // put in Codable Struct to decode
}
