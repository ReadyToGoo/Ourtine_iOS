//
//  LF_CompletionSigninViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/08/09.
//

import UIKit
import SnapKit

class LF_CompletionSigninViewController: UIViewController {
    
    lazy var nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle("네, 좋아요!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .app_PrimaryColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        SignUpFlowManager.shared.printself()
        
        
        var username = "민선"
        
        if let name = SignUpFlowManager.shared.signUpInformation.nickName {
            username = name
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo2")
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 3, height: 2)
        imageView.layer.shadowRadius = 4
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(218)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        let welcomeLabel = UILabel()
        let fullText = " [ \(username) ]님, 만나서 반가워요!"
        let attributedText = NSMutableAttributedString(string: fullText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 3, length: username.count))
        
        welcomeLabel.attributedText = attributedText
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        welcomeLabel.numberOfLines = 1
        view.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.width.equalTo(664)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(-105)
        }
        
        let additionalTextLabel = UILabel()
        additionalTextLabel.text = "더 나은 나를 위해\n내게 맞는 습관을 찾으러 가볼까요?"
        additionalTextLabel.numberOfLines = 2
        additionalTextLabel.textAlignment = .center
        additionalTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        additionalTextLabel.textColor = .black
        view.addSubview(additionalTextLabel)
        
        additionalTextLabel.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(110)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(-18)
        }
        
        view.addSubview(nextBtn)
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    }
    
    @objc private func nextBtnTapped(_ sender: UIButton) {
        // 코드
        let signUpData = SignUpFlowManager.shared.signUpInformation
        signUpRequest(signUpData)
    }
    
    func signUpRequest(_ data : CreatingSignUpInfo) {
        
        let inputData = SignUpInfo(favoriteCategoryList: data.habitCategory!, goal: data.resolutionString ?? "...ㅠ", marketingAgreed: data.agreeList.marketingAgreed!, nickname: data.nickName!, privacyAgreed: data.agreeList.privacyAgreed!, termsAgreed: data.agreeList.termsAgreed!)
        
        let wrapper = MoyaWrapper<AuthAPI>()
        wrapper.requestSuccessRes(target: .postSignUp(info: inputData), instance: data_postSignUp.self){ result in
            switch result {
            case .success(let result):
                print(result)
                
                let viewController = AppTabBarController()
                self.navigationController?.pushViewController(viewController, animated: true)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


import SwiftUI
struct LF_CompletionSigninViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = LF_CompletionSigninViewController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
