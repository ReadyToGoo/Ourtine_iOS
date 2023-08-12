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
        termsTextView.text = "시작하기 버튼을 누르면 Ready To Go 이용약관에 동의하는 것으로 간주합니다."
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
