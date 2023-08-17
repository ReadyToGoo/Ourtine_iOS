//
//  PrimaryViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/16.
//

import Foundation
import UIKit

class PrimaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .app_SecondaryColor2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 토큰을 영구저장소에서 가져오기
        myInfo.getMyToken()
        
        // 토큰이 존재할 때
        if myInfo.myToken != nil {
            
            // 토큰의 만료 기간 확인
            guard myInfo.checkMyTokenValidation() == true else {
                // 토큰 만료된 경우 로그인 화면 푸쉬
                presentVCwithDarkNavCon(LF_LoginViewController.self)
                return }
            
            // 유저 상태 확인
            guard let status = currentUserStatus() else {
                // 정의되지 않은 상태인 경우 로그인 화면 푸쉬
                presentVCwithDarkNavCon(LF_LoginViewController.self)
                return }
            
            // 회원가입 또는 홈화면 진행
            presentVCbyStatus(status: status)
            
        }
        // 토큰이 존재하지 않을 때
        else {
            // 로그인 화면 푸쉬
            presentVCwithDarkNavCon(LF_LoginViewController.self)
        }
        
    }
    
    /// 현재 유저 정보에서 유저status를 반환합니다.
    func currentUserStatus() -> String? {
        if let status = myInfo.mySignUpStatus {
            switch status {
            case "SIGNUP_PROGRESS" :
                print("임시 회원가입 진행 유저")
                return "SignUP"
            case "NORMAL_ACTIVE" :
                print("활성화 일반 유저")
                return "Main"
            case "NORMAL_INACTIVE" :
                print("비활성화 일반 유저")
                return "Main"
            case "BANNED_ACTIVE" :
                print("활성화 서비스 차단 유저")
                return "Main"
            case "BLOCKED_INACTIVE" :
                print("비활성화 서비스 차단 유저")
                return "Main"
            default :
                print("인증되지 않은 회원 상태입니다. 로그인을 진행해주세요.")
                return nil
            }
        }
        else {
            print("토큰 발급이 제대로 진행되지 않았습니다. 로그인을 진행해주세요.")
            return nil
        }
    }
    
    /// 현재 유저의 Status에 따라 알맞는 화면을 present합니다.
    func presentVCbyStatus(status: String) {
        switch status {
        case "SignUP" :
            let VC = DarkStatusBar_NavigationController(rootViewController: LF_SetUsernameViewController())
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        case "Main" :
            let VC = AppTabBarController()
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        default :
            makeAlert(title: "Status Error", message: "인증되지 않은 상태입니다. 로그인을 다시 진행해주세요.", completion: {
                self.presentVCwithDarkNavCon(LF_LoginViewController.self)
            })
            return
        }
    
    }
    
    /// 인자로 받은 ViewController 타입을 통해 해당 VC를 검은색 스테이터스바의 NavigationViewController로 push합니다.
    func presentVCwithDarkNavCon(_ viewControllerType: UIViewController.Type) {
        let viewController = viewControllerType.init()
        let VC = DarkStatusBar_NavigationController(rootViewController: viewController)
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false)
    }
    
}
