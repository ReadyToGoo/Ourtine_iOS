//
//  SearchedUserProfile.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

class UserModel {
    var userKey: Int
    var profileImage: String?
    var nickName: String
    var isFollowing: Bool

    init(_ userKey: Int, _ profileImage: String?, _ nickName: String, _ isFollowing: Bool?) {
        self.userKey = userKey
        self.profileImage = profileImage
        self.nickName = nickName
        self.isFollowing = isFollowing ?? false
    }
}

var Dummy_userList: [UserModel] = [
    UserModel(0, nil, "AAAA", true),
    UserModel(1, nil, "BBBB", nil),
    UserModel(2, nil, "CCCC", nil),
    UserModel(3, nil, "DDDD", true),
    UserModel(4, nil, "EEEE", nil),
    UserModel(5, nil, "QQQQ", true),
    UserModel(6, nil, "ZZZZ", true),
    UserModel(7, nil, "YYYY", nil),
    UserModel(8, nil, "KKKK", true),
    UserModel(9, nil, "OOOO", nil)
]
