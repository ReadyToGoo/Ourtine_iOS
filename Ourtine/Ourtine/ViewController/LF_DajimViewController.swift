//
//  LF_DajimViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/23.
//

import Foundation
import UIKit

class LF_DajimViewController: UIViewController {
    
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    // 타이틀
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "시작 전, 다짐을 적어주세요!"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    
    
    
    // 소개글
    lazy var contentTextView: UITextView = {
        let textField = UITextView()
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        textField.font = .systemFont(ofSize: 15)
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textField
    }()
    
    // 소개글 아래 텍스트 카운트
    lazy var textCount3: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .app_BrightnessColor40
        label.text = "0/50"
        return label
    }()
    
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()

    
    func addSubviews(){
        [
            navigationBar,
            topLabel,
            contentTextView,
            textCount3,
            nextBtn
        ].forEach {self.view.addSubview($0)}
    }
    
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(30)
        }
        
        contentTextView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(150)
            $0.top.equalTo(topLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
//        textCount3.snp.makeConstraints {
//            $0.trailing.equalTo(contentTextView).offset(-5)
//            $0.top.equalTo(contentTextView.snp.bottom).offset(5)
//        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addSubviews()
        setConstraint()
        
        self.nextBtn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 회원가입 플로우의 데이터를 저장
        SignUpFlowManager.shared.signUpInformation.resolutionString = self.contentTextView.text
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (SignUpFlowManager.shared.signUpInformation.resolutionString != nil
        ) else {
            print("SignUpFlowManager.shared.signUpInformation.resolutionString에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        print("저장 성공")
        return true
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        // 코드
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        let viewController = LF_TermsViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


import SwiftUI
struct LF_DajimViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = LF_DajimViewController()
            return ViewController
        }
    }
}
