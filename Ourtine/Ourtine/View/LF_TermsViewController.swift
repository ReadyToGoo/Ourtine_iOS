//
// LF_TermsViewController.swift
// Ourtine
//
// Created by 박민선 on 2023/08/03.
//

import UIKit
import SnapKit

class LF_TermsViewController: UIViewController {
    
    lazy var navigationBar: Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var allAgreeCheckbox: UIButton = {
        let checkbox = UIButton()
        checkbox.setImage(UIImage(systemName: "square"), for: .normal)
        checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkbox.tintColor = .app_PrimaryColor
        checkbox.tag = 0
        checkbox.addTarget(self, action: #selector(allAgreeCheckboxTapped(_:)), for: .touchUpInside)
        return checkbox
    }()
    
    let checkboxTexts = ["전체 동의", "‘Ourtine’ 이용약관에 동의합니다. (필수)", "개인정보 수집/이용에 동의합니다. (필수)", "이벤트 혜택/정보 수신에 동의합니다. (선택)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        
        navigationController?.navigationBar.isHidden = true
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        view.addSubview(allAgreeCheckbox)
        allAgreeCheckbox.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(171)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let mainLabel = UILabel()
        mainLabel.numberOfLines = 2
        mainLabel.text = "Our-tine을 이용하려면\n약관 동의가 필요해요"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        view.addSubview(mainLabel)
        
        var lastView: UIView?
        for (index, checkboxText) in checkboxTexts.enumerated() {
            let checkbox = UIButton()
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            checkbox.tintColor = .app_PrimaryColor
            checkbox.tag = index
            checkbox.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
            view.addSubview(checkbox)
            
            let checkboxLabel = UILabel()
            checkboxLabel.text = checkboxText
            checkboxLabel.font = .systemFont(ofSize: 15)
            checkboxLabel.textColor = UIColor(red: 129/255, green: 128/255, blue: 128/255, alpha: 1)
            checkboxLabel.textAlignment = .left
            checkboxLabel.numberOfLines = 1
            view.addSubview(checkboxLabel)
            
            checkbox.snp.makeConstraints { make in
                make.width.height.equalTo(25)
                make.left.equalToSuperview().offset(25)
                if let lastView = lastView {
                    make.top.equalTo(lastView.snp.bottom).offset(10)
                } else {
                    make.top.equalToSuperview().offset(171)
                }
            }
            
            checkboxLabel.snp.makeConstraints { make in
                make.left.equalTo(checkbox.snp.right).offset(10)
                make.centerY.equalTo(checkbox)
                make.height.equalTo(26)
            }
            
            if index > 0 {
                let termsDetailBtn = UIButton()
                termsDetailBtn.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
                termsDetailBtn.tintColor = .gray
                termsDetailBtn.addTarget(self, action: #selector(viewTermsButtonTapped(_:)), for: .touchUpInside)
                termsDetailBtn.tag = index
                view.addSubview(termsDetailBtn)
                
                termsDetailBtn.snp.makeConstraints { make in
                    make.width.equalTo(20)
                    make.height.equalTo(30)
                    make.centerY.equalTo(checkboxLabel)
                    make.right.equalToSuperview().offset(-30)
                }
            }
            
            lastView = checkboxLabel
        }
        
        let fifthLabel = UILabel()
        fifthLabel.text = "Ourtine에서 제공하는 이벤트/혜택 등 다양한 정보를 푸시 또는 이메일로 받아보실 수 있습니다."
        fifthLabel.font = .systemFont(ofSize: 12)
        fifthLabel.textColor = UIColor(red: 129/255, green: 128/255, blue: 128/255, alpha: 1)
        fifthLabel.textAlignment = .left
        fifthLabel.numberOfLines = 0
        view.addSubview(fifthLabel)
        
        fifthLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(61)
            make.top.equalTo(lastView?.snp.bottom ?? 171).offset(-8)
            make.width.equalTo(252)
            make.height.equalTo(44)
        }
        
        let nextButton = UIButton()
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .app_PrimaryColor
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.95)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(41)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConstraints() {
        let mainLabel = view.subviews.compactMap { $0 as? UILabel }.first
        mainLabel?.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(80)
            make.width.equalTo(348)
            make.height.equalTo(62)
        }
    }
    
    @objc private func checkBoxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @objc private func allAgreeCheckboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        // Update the other checkboxes
        for index in 1..<checkboxTexts.count {
            let checkbox = view.viewWithTag(index) as? UIButton
            checkbox?.isSelected = sender.isSelected
        }
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        // ...
    }
    
    @objc private func viewTermsButtonTapped(_ sender: UIButton) {
        // 약관으로 이동
    }
}


import SwiftUI
struct LF_TermsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = LF_TermsViewController()
            return viewController
        }
    }
}
