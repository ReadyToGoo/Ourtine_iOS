//
//  HC_introduceView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

class HabitCreate_introduceView: UIView {
    
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "습관을 소개해볼까요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    // 사진 첨부 버튼은 UIImagePickerController로 구현해야합니다
    // 나중에
    lazy var addImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("사진 첨부", for: .normal)
        btn.backgroundColor = UIColor.app_PrimaryColor2
        btn.layer.cornerRadius = 8.0
        btn.clipsToBounds = true // 사진 선택으로 배경사진이 바뀔 때 테두리에 잘리게
        btn.imageView?.contentMode = .scaleAspectFill // 배경 사진이 바뀔 때 비율 유지하게
        return btn
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 2.0
        textField.textAlignment = .left
        textField.textColor = .black
        textField.contentVerticalAlignment = .top
        textField.placeholder = "소개글"
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var dummyLabel: UILabel = {
        let label = UILabel()
        label.text = "#해시태그\n#간단한 #생산적인 #etc"
        label.numberOfLines = 0
        label.textColor = .gray
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
            addImageButton,
            textField,
            dummyLabel,
            nextBtn
        ].forEach {self.addSubview($0)}
    }
    
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addImageButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(80)
            $0.top.equalTo(topLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.top.equalTo(addImageButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        dummyLabel.snp.makeConstraints {
            $0.leading.equalTo(textField)
            $0.top.equalTo(textField.snp.bottom).offset(20)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide ).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addSubviews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
struct HabitCreate_introduceView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_introduceViewController()
            return ViewController
        }
    }
}

