//
//  HabitAPI sending Struct.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/15.
//

import Foundation

// MARK: - HabitSessionAPI에서 송신할 때 사용되는 struct입니다.

/// HabitSessionAPI의 .patchUploadSessionReview에서 사용되는
/// 회고 구조체 입니다
struct habitReview: Encodable {
    let emotion: String
    let starRate: Int
}

/// HabitSessionAPI의 .patchMVPVote에서 사용되는
/// 투표  구조체 입니다
struct mvpVote: Encodable {
    let mvpVote: Int
}
