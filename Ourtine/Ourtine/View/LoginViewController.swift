//
//  LoginViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/07/28.
//
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstLabel = UILabel()
        firstLabel.text = "시작하기"
        firstLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        firstLabel.textColor = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1.0)
        firstLabel.textAlignment = .center
        firstLabel.baselineAdjustment = .alignCenters
        
        let secondLabel = UILabel()
        secondLabel.text = "더 나은 습관을 위해,\nReady to GO?"
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        secondLabel.textColor = .black
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 2

        
        self.view.addSubview(firstLabel)
        self.view.addSubview(secondLabel)
        
        firstLabel.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(29)
            make.top.equalToSuperview().offset(107)
            make.left.equalToSuperview().offset(152)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.width.equalTo(230)
            make.height.equalTo(48)
            make.top.equalTo(firstLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(86)
        }
        

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon.png")
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(236)
            make.left.equalToSuperview().offset(141)
        }
        
        
        // MARK: - 시작하기 버튼
        let kakaoBtn = UIButton()
        kakaoBtn.setTitle("카카오로 시작하기", for: .normal)
        kakaoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        kakaoBtn.setTitleColor(UIColor(red: 53/255, green: 29/255, blue: 28/255, alpha: 1.0), for: .normal)
        kakaoBtn.backgroundColor = UIColor(red: 239/255, green: 219/255, blue: 73/255, alpha: 1.0)
        kakaoBtn.layer.cornerRadius = 8
        
        self.view.addSubview(kakaoBtn)
        
        // Apply constraints using SnapKit
        kakaoBtn.snp.makeConstraints { make in
            make.width.equalTo(277)
            make.height.equalTo(40.49)
            make.top.equalToSuperview().offset(403)
            make.left.equalToSuperview().offset(58)
        }
        
        let appleBtn = UIButton()
        appleBtn.setTitle("애플로 시작하기", for: .normal)
        appleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        appleBtn.setTitleColor(UIColor.white, for: .normal)
        appleBtn.backgroundColor = UIColor.black
        appleBtn.layer.cornerRadius = 8

        
        // Add the button to the view
        self.view.addSubview(appleBtn)
        
        // Apply constraints using SnapKit
        appleBtn.snp.makeConstraints { make in
            make.width.equalTo(277)
            make.height.equalTo(40.49)
            make.top.equalToSuperview().offset(452.48)
            make.left.equalToSuperview().offset(58)
        }
        

        
        let termsTextView = UITextView()
        termsTextView.text = "시작하기 버튼을 누르면 Ready To Go 이용약관에 동의하는 것으로 간주합니다."
        termsTextView.font = UIFont.systemFont(ofSize: 9)
        termsTextView.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
        termsTextView.isEditable = false
        termsTextView.isScrollEnabled = false
        termsTextView.textAlignment = .center
        termsTextView.backgroundColor = UIColor.clear

        self.view.addSubview(termsTextView)

        
        termsTextView.snp.makeConstraints { make in
            make.centerX.equalTo(appleBtn)
            make.top.equalToSuperview().offset(600)
            make.width.equalTo(300)
        }
    }
}

import SwiftUI
struct LoginViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = LoginViewController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
