//
//  MemberModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

class MemberModel {
    var badge: String?
    var image: String?
    var name: String
    
    init(_ badge: String?, _ image: String?, _ name: String) {
        self.badge = badge
        self.image = image
        self.name = name
    }
}

let Dummy_memberList: [MemberModel] = [
    MemberModel("Crown", nil, "name1"),
    MemberModel(nil, nil, "name2"),
    MemberModel("Crown", nil, "name3"),
    MemberModel(nil, nil, "name4"),
    MemberModel(nil, nil, "name5"),
    MemberModel(nil, nil, "name6"),
    MemberModel("Crown", nil, "name7"),
    MemberModel(nil, nil, "name8"),
    MemberModel(nil, nil, "name9"),
    MemberModel(nil, nil, "name10"),
    MemberModel("Crown", nil, "name11"),
    MemberModel(nil, nil, "name12")
]