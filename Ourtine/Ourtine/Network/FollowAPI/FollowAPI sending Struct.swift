//
//  FollowAPI sending Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/14.
//

import Foundation

// MARK: - FollowAPI에서 송신할 때 사용되는 struct입니다.

/// FollowAPI의 .postFollowUser에서 사용되는
/// 팔로우할 유저 구조체입니다.
struct userTarget: Encodable {
    var userId : Int
}
