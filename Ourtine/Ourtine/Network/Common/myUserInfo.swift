//
//  currentUserInfo.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/07.
//

import Foundation

let myInfo = MyInfo.shared

public class MyInfo {
    
    static let shared = MyInfo()
    public init() {
        // 초기화 내용 작성
//        getMyToken()
//        print("getMyToken 완료 init 완료")
    }
    
    /// 현재 유저의 토큰입니다
    /// 값이 변경될 때마다 myID와 mySignUpStatus를 변경합니다.
    var myToken: String? {
        didSet {
            print("myToken is : \(myInfo.myToken!)")
            if let infoTuple = extractUserInfo(from: myInfo.myToken){
                myInfo.myID = Int(infoTuple.0)!
                myInfo.mySignUpStatus = infoTuple.1
            }
            else {
                myInfo.myID = nil
                myInfo.mySignUpStatus = nil
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
    
    /// UserDefaults에서 토큰 값을 가져옵니다.
    func getMyToken() {
        if let token = UserDefaults.standard.string(forKey: "myToken") {
            myInfo.myToken = token
        } else {
            print("error : 저장된 토큰이 없습니다")
        }
    }
    
    /// 토큰을 초기화 합니다.
    func resetMyToken() {
        myInfo.myToken = nil
    }
    
    
}


