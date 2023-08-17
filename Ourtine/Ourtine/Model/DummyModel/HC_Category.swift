//
//  HC_Category.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

class HC_Category {
    var name: String
    var image: String
    
    init(_ name: String, _ image: String = "") {
        self.name = name
        self.image = image
    }
}

let Dummy_HC_Categories: [HC_Category] = [
    HC_Category("운동"),
    HC_Category("생활습관"),
    HC_Category("독서"),
    HC_Category("스터디"),
    HC_Category("외국어"),
    HC_Category("취미생활"),
    HC_Category("돈관리"),
    HC_Category("커리어")
]
