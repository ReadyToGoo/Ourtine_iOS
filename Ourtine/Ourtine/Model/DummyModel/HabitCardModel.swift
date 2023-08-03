//
//  HabitCardModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/28.
//

class HabitCardModel {
    
    var image: String?
    var title: String
    var habitName: String
    var userName: String
    var userImage: String?
    
    init(_ image: String? = nil, _ title: String, _ habitName: String, _ userName: String, _ userImage: String? = nil) {
        self.image = image
        self.title = title
        self.habitName = habitName
        self.userName = userName
        self.userImage = userImage
    }
}

let Dummy_habitCards: [HabitCardModel] = [
    HabitCardModel(nil, "독서", "아침마다 책읽기", "Test Name 1"),
    HabitCardModel(nil, "외국어", "퇴근 후 공부하기", "Test Name 2"),
    HabitCardModel(nil, "운동", "아침마다 조깅하기", "Test Name 3"),
    HabitCardModel(nil, "돈 관리", "가계부 작성하기", "Test Name 4"),
    HabitCardModel(nil, "외국j", "Test Habit 5", "Test Name 5"),
    HabitCardModel(nil, "Test Title 6", "Test Habit 6", "Test Name 6"),
    HabitCardModel(nil, "Test Title 7", "Test Habit 7", "Test Name 7"),
    HabitCardModel(nil, "Test Title 8", "Test Habit 8", "Test Name 8")
]
