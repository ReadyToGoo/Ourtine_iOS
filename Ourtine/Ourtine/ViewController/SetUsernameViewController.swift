//
//  SetUsernameViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/07/28.
//

import UIKit
import SnapKit

class SetUsernameViewController: UIViewController, UITextFieldDelegate {

    let indicatorTextField = UIView()
    
    // MARK: - 닉네임 제한 경고 메시지
    lazy var warningMessageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.8)
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.isHidden = true
        
        self.view.addSubview(view)
        
        return view
    }()
    
    lazy var warningMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        warningMessageView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return label
    }()
    

    func isNicknameValid(_ nickname: String) -> Bool {
        if nickname.count < 2 {
            warningMessageLabel.text = "닉네임은 2글자 이상으로 적어주세요!"
            return false
        }
        
        let regex = ".*[^A-Za-z0-9가-힣ㄱ-ㅎㅏ-ㅣ\\s]+.*"
        
        if nickname.range(of: regex, options: .regularExpression) != nil {
            warningMessageLabel.text = "특수문자 및 이모티콘 사용은 불가능해요!"
            return false
        }
        
        if nickname.count > 10 {
            warningMessageLabel.text = "닉네임은 10글자 이하로 적어주세요!"
            return false
        }
        
        if nickname.lowercased() == "example" {
            warningMessageLabel.text = "이미 사용되고 있는 닉네임이에요!"
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        
        let nicknameLabel = UILabel()
        nicknameLabel.text = "닉네임을 알려주세요!"
        nicknameLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        nicknameLabel.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        nicknameLabel.numberOfLines = 1
        self.view.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview().offset(-navigationBarHeight - 280)
            make.width.equalTo(273)
            make.height.equalTo(25)
        }
        
        // 텍스트필드 설정
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 29)
        textField.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        self.view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-navigationBarHeight - 233)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(320)
            make.height.equalTo(30)
        }
        
        // Indicator TextField 추가
        indicatorTextField.backgroundColor = UIColor(red: 103/255, green: 125/255, blue: 238/255, alpha: 1.0)
        self.view.addSubview(indicatorTextField)
        
        indicatorTextField.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(textField)
            make.height.equalTo(2)
        }
        
        self.view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(381)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-20) 
        }
        // 다른 SubView에 의해 가려진 btn을 앞으로 보내주기
        view.bringSubviewToFront(nextButton)
    }
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(SetUsernameViewController.self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        // 코드 죄
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateWarningMessageViewPosition()
    }
    
    func updateWarningMessageViewPosition() {
        let centerY = view.bounds.height / 2 + 630
        warningMessageView.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(centerY)
        }
    }
}

import SwiftUI
struct SetUsernameViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = SetUsernameViewController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
