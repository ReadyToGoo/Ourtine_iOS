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
    
    init(_ image: String? = nil, _ title: String, _ habitName: String, _ userName: String) {
        self.image = image
        self.title = title
        self.habitName = habitName
        self.userName = userName
    }
}

let Dummy_habitCards: [HabitCardModel] = [
    HabitCardModel(nil, "Test Title 1", "Test Habit 1", "Test Name 1"),
    HabitCardModel(nil, "Test Title 2", "Test Habit 2", "Test Name 2"),
    HabitCardModel(nil, "Test Title 3", "Test Habit 3", "Test Name 3"),
    HabitCardModel(nil, "Test Title 4", "Test Habit 4", "Test Name 4"),
    HabitCardModel(nil, "Test Title 5", "Test Habit 5", "Test Name 5"),
    HabitCardModel(nil, "Test Title 6", "Test Habit 6", "Test Name 6"),
    HabitCardModel(nil, "Test Title 7", "Test Habit 7", "Test Name 7"),
    HabitCardModel(nil, "Test Title 8", "Test Habit 8", "Test Name 8")
]
