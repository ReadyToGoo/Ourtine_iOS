//
//  MemberModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

class MemberModel: Hashable {
    var userId: Int
    var badge: String?
    var image: String?
    var name: String
    
    init(_ badge: String?, _ image: String?, _ name: String, _ userId: Int = 9999) {
        self.userId = userId
        self.badge = badge
        self.image = image
        self.name = name
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(userId)
        hasher.combine(name)
    }
    
    static func == (lhs: MemberModel, rhs: MemberModel) -> Bool {
        return lhs.userId == rhs.userId && lhs.name == rhs.name
    }
}

let Dummy_memberList: [MemberModel] = [
    MemberModel("Crown", nil, "name1"),
    MemberModel(nil, nil, "name2"),
    MemberModel("Crown", nil, "name3"),
    MemberModel(nil, nil, "name4"),
    MemberModel(nil, nil, "name5"),
    MemberModel(nil, nil, "name6")
]

let Dummy_participatingMemberList: [MemberModel] = [
    MemberModel("Crown", "habitBackgroundExample", "name1", 1),
    MemberModel(nil, nil, "name2", 2),
    MemberModel("Crown", nil, "name3", 3),
    MemberModel(nil, nil, "name4", 4)

]
