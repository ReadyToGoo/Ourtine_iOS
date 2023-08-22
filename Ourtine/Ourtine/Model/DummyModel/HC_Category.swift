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
    HC_Category("운동", "1exercise"),
    HC_Category("생활습관", "1lifestyle"),
    HC_Category("독서", "1reading"),
    HC_Category("스터디", "1study"),
    HC_Category("외국어", "1language"),
    HC_Category("취미생활", "1hobby"),
    HC_Category("돈관리", "1money"),
    HC_Category("커리어", "1career")
]
