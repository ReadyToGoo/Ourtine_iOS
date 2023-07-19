//
//  SearchedHabitProfile.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

class HabitModel {
    var habitKey: Int
    var profileImage: String?
    var habitName: String
    var hastags: String

    init(_ habitKey: Int, _ profileImage: String? = nil, _ habitName: String, _ hastags: String) {
        self.habitKey = habitKey
        self.profileImage = profileImage
        self.habitName = habitName
        self.hastags = hastags
    }
}

var Dummy_habitList: [HabitModel] = [
    HabitModel(0, nil, "ZXCV", "#1 #2 #3"),
    HabitModel(1, nil, "ASDF", "#2 #3"),
    HabitModel(2, nil, "QWER", "#1"),
    HabitModel(3, nil, "DGFH", "#11 #22"),
    HabitModel(4, nil, "CBVN", "#1 #22"),
    HabitModel(5, nil, "JFHG", "#1 #30"),
    HabitModel(6, nil, "UYTR", "#11 #2"),
    HabitModel(7, nil, "HJKL", "#1 #3"),
    HabitModel(8, nil, "UIOP", "#2 #33"),
    HabitModel(9, nil, "GFSD", "#11 #22 #33")
]
