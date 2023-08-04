//
// TermsViewController.swift
// Ourtine
//
// Created by 박민선 on 2023/08/03.
//

import UIKit
import SnapKit

class TermsViewController: UIViewController {

    lazy var navigationBar: Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        
        
        view.backgroundColor = .white

        // title
        let mainLabel = UILabel()
        mainLabel.numberOfLines = 2
        mainLabel.text = "Ourtine을 이용하려면\n약관 동의가 필요해요"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        view.addSubview(mainLabel)

        let checkboxTexts = ["전체 동의", "‘Ourtine’ 이용약관에 동의합니다. (필수)", "개인정보 수집/이용에 동의합니다. (필수)", "이벤트 혜택/정보 수신에 동의합니다. (선택)"]

        let checkboxCount = 3
        var checkboxButtons: [UIButton] = []
        for index in 0..<checkboxCount {
            let button = UIButton()
            button.setImage(UIImage(systemName: "square")?.withTintColor(.black), for: .normal)
            button.setImage(UIImage(systemName: "checkmark.square.fill")?.withTintColor(.black), for: .selected)
            button.tag = index
            button.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
            checkboxButtons.append(button)
            view.addSubview(button)
        }

        var lastView: UIView?
        for (index, checkboxText) in checkboxTexts.enumerated() {
            let checkbox = UIButton()
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            checkbox.tintColor = .black
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
            }

            if index > 0 {
                let termsDetailBtn = UIButton()
                termsDetailBtn.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.black), for: .normal)
                termsDetailBtn.tintColor = .black
                termsDetailBtn.addTarget(self, action: #selector(viewTermsButtonTapped(_:)), for: .touchUpInside)
                termsDetailBtn.tag = index
                view.addSubview(termsDetailBtn)

                termsDetailBtn.snp.makeConstraints { make in
                    make.width.equalTo(20)
                    make.height.equalTo(14)
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
        
        let nextButton: UIButton = {
            let button = UIButton()
            button.setTitle("다음", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
            return button
        }()

        // Add the nextButton to the view
        view.addSubview(nextButton)

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.95)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
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

    @objc private func nextButtonTapped(_ sender: UIButton) {
        // 추후 구현
    }
    @objc private func viewTermsButtonTapped(_ sender: UIButton) {
        // 약관 전문으로 이동하는 코드 구현자리
        // let termsDetailViewController = TermsDetailViewController()
        // self.navigationController?.pushViewController(termsDetailViewController, animated: true)
    }

}

import SwiftUI
struct TermsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = TermsViewController()
            return viewController
        }
    }
}
