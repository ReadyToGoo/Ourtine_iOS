//
//  currentUserInfo.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/07.
//

import Foundation

let myInfo = MyInfo.shared

class MyInfo {
    
    static let shared = MyInfo()
    private init() {}
    
    var myToken: String? {
        didSet {
            print("myToken is : \(myInfo.myToken!)")
            if let infoTuple = extractUserInfo(from: myInfo.myToken){
                myInfo.myID = Int(infoTuple.0)!
                myInfo.mySignUpStatus = infoTuple.1
            }
        }
    }
    
    var myID: Int? {
        didSet {
            print("myID changed : \(myInfo.myID!)")
        }
    }
    var mySignUpStatus: String? {
        didSet {
            print("mySignUpStatus changed : \(myInfo.mySignUpStatus!)")
        }
    }
    
    
    /// myInfo에 토큰값을 설정하고, UserDefaults에 토큰을 저장합니다.
    func setMyToken(cookieString : String) {
        // 쿠키에서 "Authorization=Bearer%20" 제외하고 추출
        let token = extractTokenPrefix(from: cookieString)
        // 토큰으로 저장
        myInfo.myToken = token
        UserDefaults.standard.set(myInfo.myToken, forKey: "myToken")
    }
    
    
}


