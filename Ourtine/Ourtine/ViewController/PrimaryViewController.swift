//
//  PrimaryViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/16.
//

import Foundation
import UIKit

/// 이거 내용이 전부 LF_LoginViewController에 들어가야 합니다..!
class PrimaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .app_SecondaryColor2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myInfo.getMyToken()
        
        // 토큰이 존재할 때
        if myInfo.myToken != nil {
            // 상태 확인
            guard let status = currentUserStatus() else { return }
            // 회원가입 또는 홈화면 진행
            presentVCbyStatus(status: status)
        }
        // 토큰이 존재하지 않을 때
        else {
            // 로그인 화면 푸쉬
            let VC = DarkStatusBar_NavigationController(rootViewController: LF_LoginViewController())
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
            
            // 여기 내용은 LF_LoginViewController에 들어가야 하네요
//            let VC = KakaoLoginViewController()
//            VC.modalPresentationStyle = .fullScreen
//            VC.didUserGetToken = { isTrue in
//                if isTrue == true {
//                    // 상태 확인
//                    guard let status = self.currentUserStatus() else { return }
//                    // 회원가입 또는 홈화면 진행
//                    self.presentVCbyStatus(status: status)
//                }
//            }
//            self.present(VC, animated: true)
        }
        
    }
    
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
            print("토큰 발급이 제대로 진행되지 않았습니다. 로그인 먼저 진행해주세요.")
            return nil
        }
    }
    
    func presentVCbyStatus(status: String) {
        switch status {
        case "SignUP" :
            let VC = DarkStatusBar_NavigationController(rootViewController: LF_SetUsernameViewController())
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        case "Main" :
            let VC = DarkStatusBar_NavigationController(rootViewController: AppTabBarController())
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        default :
            print("인증되지 않은 상태입니다")
            return
        }
    
    }
    
}
