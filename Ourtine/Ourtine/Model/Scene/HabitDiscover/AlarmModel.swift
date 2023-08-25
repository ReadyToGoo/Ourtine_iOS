//
//  AlarmModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/29.
//

class AlarmModel {
    var title: String
    var date: String
    var content: String
    
    init(_ title: String, _ date: String, _ content: String) {
        self.title = title
        self.date = date
        self.content = content
    }
}

let Dummy_alarmModels: [AlarmModel] = [
    AlarmModel("Test Title", "Test Date", """
    Test Content 1
    1
    1
    """),
    AlarmModel("Test Title", "Test Date", """
    Test Content 2
    2
    2
    """),
    AlarmModel("Test Title", "Test Date", """
    Test Content 3
    3
    3
    """),
    AlarmModel("Test Title", "Test Date", """
    Test Content 4
    4
    4
    """)
]
