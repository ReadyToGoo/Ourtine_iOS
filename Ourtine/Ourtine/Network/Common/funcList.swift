//
//  funcList.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/07.
//

import Foundation
import Moya
import UIKit

////raw하게 쓰는 Moya
//func getHabitData() {
//    let provider = MoyaProvider<HabitsAPI>()
//    provider.request(.recommend) {
//        switch $0 {
//            ///여러가지 케이스에 대해서 nil로 반환해버려서 애매함
//        case let .success(response):
//            print(response.description)
//            let result_1 = try? response.map(recommendContent.self)
//            print(result_1)
//        case let .failure(error):
//            print(error.localizedDescription)
//        }
//    }
//}


func usingWrapper() {
    let wrapper = MoyaWrapper<HabitAPI>()
    wrapper.requestSuccessRes(target: .postCreateHabit(imageData: UIImage(named: "feeling1")!.pngData()!, content: habitCreationContent(category: "CAREER", days: ["FRI"], detail: "string", endDate: "2023-10-15", endTime: "string", followerLimit:  6, habitStatus: "PRIVATE", hashtags: ["string"], startDate: "2023-08-15", startTime: "string", title: "TEST")), instance: data_postCreateHabit.self)
    { result in
        switch result {
        case .success(let result):
            print(result)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

//(target: .postCreateHabit(imageData: UIImage(named: "feeling1")!.pngData()!, content: habitCreationContent(category: "CAREER", days: ["FRI"], detail: "string", endDate: "2023-08-15", endTime: "string", followerLimit:  0, habitStatus: "PRIVATE", hashtags: ["string"], startDate: "2023-08-15", startTime: "string", title: "TEST")), instance: data_postCreateHabit.self)

//(target: .patchMyProfileImage(imageData: (UIImage(named: "feeling1")?.pngData())!), instance: data_patchMyProfileImage.self)
