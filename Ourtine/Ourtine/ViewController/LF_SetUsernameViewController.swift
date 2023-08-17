//
//  LF_SetUsernameViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/07/28.
//

import UIKit
import SnapKit

class LF_SetUsernameViewController: UIViewController, UITextFieldDelegate {
    
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
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
    
    lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 29)
        textField.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    
    func isNicknameValid(_ nickname: String) -> Bool {
        if nickname.count < 2 {
            warningMessageLabel.text = "닉네임은 2글자 이상으로 적어주세요!"
            return false
        }
        
        // MARK: - 사용자가 오입력했을 때 나타나는 경고메시지입니다.
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
        
        self.view.backgroundColor = .white
        SignUpFlowManager.shared.printself()
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        
        navigationController?.navigationBar.isHidden = true
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        navigationItem.title = "회원가입"
        
        if let font = UIFont(name: "System", size: 16) {
            navigationController?.navigationBar.titleTextAttributes = [.font: font]
        }
        
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
        self.view.addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-navigationBarHeight - 233)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(320)
            make.height.equalTo(30)
        }
        
        // Indicator TextField 추가
        indicatorTextField.backgroundColor = UIColor(hexCode: "#FF4F17")
        self.view.addSubview(indicatorTextField)
        
        indicatorTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(nickNameTextField)
            make.height.equalTo(2)
        }
        
        self.view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(326)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-20)
        }
        view.bringSubviewToFront(nextBtn)
    }
    
    
    let nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexCode: "#FF4F17")
        button.layer.cornerRadius = 8
        return button
    }()
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 회원가입 플로우의 데이터를 저장
        let nickName = self.nickNameTextField.text
        SignUpFlowManager.shared.signUpInformation.nickName = nickName
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (SignUpFlowManager.shared.signUpInformation.nickName != nil) else {
            print("SignUpFlowManager.shared.signUpInformation.nickName에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        print("저장 성공")
        return true
    }
    
    @objc private func nextBtnTapped(_ sender: UIButton) {
        // 코드
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        let viewController = LF_SelectionOfHBViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
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
struct  LF_SetUsernameViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController =  LF_SetUsernameViewController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
