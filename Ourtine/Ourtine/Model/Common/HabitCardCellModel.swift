//
//  HabitCardModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/28.
//

class HabitCardModel {
    
    var habitId: Int?
    var image: String?
    var title: String
    var habitName: String
    var userName: String
    var userImage: String?
    var days: [String]?
    var startTime:String?
    var endTime:String?

    init(habitId: Int? = nil, image: String? = nil, title: String, habitName: String, userName: String, userImage: String? = nil, days: [String]? = nil, startTime: String? = nil, endTime: String? = nil) {
        self.habitId = habitId
        self.image = image
        self.title = title
        self.habitName = habitName
        self.userName = userName
        self.userImage = userImage
        self.days = days
        self.startTime = startTime
        self.endTime = endTime
    }
}

//let Dummy_habitCards: [HabitCardModel] = [
//    HabitCardModel(0, nil, "독서", "아침마다 책읽기", "Test Name 1"),
//    HabitCardModel(1, nil, "외국어", "퇴근 후 공부하기", "Test Name 2"),
//    HabitCardModel(2, nil, "운동", "아침마다 조깅하기", "Test Name 3"),
//    HabitCardModel(3, nil, "돈 관리", "가계부 작성하기", "Test Name 4"),
//    HabitCardModel(4, nil, "외국j", "Test Habit 5", "Test Name 5"),
//    HabitCardModel(5, nil, "Test Title 6", "Test Habit 6", "Test Name 6"),
//    HabitCardModel(6, nil, "Test Title 7", "Test Habit 7", "Test Name 7"),
//    HabitCardModel(7, nil, "Test Title 8", "Test Habit 8", "Test Name 8")
//]
