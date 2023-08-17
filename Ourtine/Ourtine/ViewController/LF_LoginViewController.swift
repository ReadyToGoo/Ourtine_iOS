//
//  LF_LoginViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/07/28.
//

import UIKit
import SnapKit

class LF_LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white // 내가 추가한 부분
        // 카카오 로그인으로부터 알림받을 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(doWhenLoginSucceed), name: NSNotification.Name("KakaoLoginSucceed"), object: nil)
        
        let secondLabel = UILabel()
        secondLabel.text = "더 나은 습관을 위해,\n내게 맞는 습관을 찾으러 가볼까요?"
        secondLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        secondLabel.textColor = .black
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 2
        
        
        self.view.addSubview(secondLabel)
        
        
        secondLabel.snp.makeConstraints { make in
            make.width.equalTo(410)
            make.height.equalTo(91)
            make.top.equalToSuperview().offset(72)
            make.left.equalToSuperview().offset(-5.5)
        }
        
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.height.equalTo(250)
            make.top.equalToSuperview().offset(190)
            make.left.equalToSuperview().offset(71)
        }
        
        
        // MARK: - 시작하기 버튼
        let kakaoBtn = UIButton()
        kakaoBtn.setTitle("카카오로 시작하기", for: .normal)
        kakaoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        kakaoBtn.setTitleColor(UIColor(red: 53/255, green: 29/255, blue: 28/255, alpha: 1.0), for: .normal)
        kakaoBtn.backgroundColor = UIColor(red: 239/255, green: 219/255, blue: 73/255, alpha: 1.0)
        kakaoBtn.layer.cornerRadius = 20
        
        self.view.addSubview(kakaoBtn)
        kakaoBtn.addTarget(self, action: #selector(tappedKaKaoLoginBtn), for: .touchUpInside) // 내가 추가한 부분
        
        kakaoBtn.snp.makeConstraints { make in
            make.width.equalTo(277)
            make.height.equalTo(40.49)
            make.top.equalToSuperview().offset(470)
            make.left.equalToSuperview().offset(58)
        }
        
        let appleBtn = UIButton()
        appleBtn.setTitle("애플로 시작하기", for: .normal)
        appleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        appleBtn.setTitleColor(UIColor.white, for: .normal)
        appleBtn.backgroundColor = UIColor.black
        appleBtn.layer.cornerRadius = 20
        
        
        self.view.addSubview(appleBtn)
        
        appleBtn.snp.makeConstraints { make in
            make.width.equalTo(277)
            make.height.equalTo(40.49)
            make.top.equalToSuperview().offset(519)
            make.left.equalToSuperview().offset(58)
        }
        
        let termsTextView = UITextView()
        termsTextView.text = "시작하기 버튼을 누르면 Ourtine 이용약관에 동의하는 것으로 간주합니다."
        termsTextView.font = UIFont.systemFont(ofSize: 10)
        termsTextView.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
        termsTextView.isEditable = false
        termsTextView.isScrollEnabled = false
        termsTextView.textAlignment = .center
        termsTextView.backgroundColor = UIColor.clear
        
        self.view.addSubview(termsTextView)
        
        
        termsTextView.snp.makeConstraints { make in
            make.centerX.equalTo(appleBtn)
            make.top.equalToSuperview().offset(700)
            make.width.equalTo(375)
        }
        
        
    }//: viewDidLoad()
    
    // 카카오 로그인 랜딩
    @objc func tappedKaKaoLoginBtn() {
        let VC = KakaoLoginViewController()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true)
    }
    
    @objc func doWhenLoginSucceed() {
        // 상태 확인
        guard let status = self.currentUserStatus() else {
            makeAlert(title: "Login Error", message: "인증되지 않은 상태입니다. 로그인을 다시 진행해주세요.", completion: nil)
            return }
        // 회원가입 또는 홈화면 진행
        self.presentVCbyStatus(status: status)
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
            print("토큰 발급이 제대로 진행되지 않았습니다. 로그인 먼저 진행해주세요.")
            return nil
        }
    }
    
    /// 현재 유저의 Status에 따라 알맞는 화면을 present합니다.
    func presentVCbyStatus(status: String) {
        switch status {
        case "SignUP" :
            let VC = LF_SetUsernameViewController()
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        case "Main" :
            let VC = AppTabBarController()
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        default :
            print("인증되지 않은 상태입니다")
            makeAlert(title: "Login Error", message: "인증되지 않은 상태입니다. 로그인을 다시 진행해주세요.", completion: nil)
            return
        }
    
    }
    
    deinit {
        // NotificationCenter의 옵저버 등록을 해제합니다.
        NotificationCenter.default.removeObserver(self)
    }
}


import SwiftUI
struct LF_LoginViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = LF_LoginViewController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
