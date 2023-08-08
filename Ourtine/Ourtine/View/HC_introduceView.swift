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
    
    // 타이틀
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "습관을 소개해볼까요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    /// 제목 텍스트 필드
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해 주세요!"
        //textField.textAlignment = .center
        textField.textColor = .app_BrightnessColor100
        //textField.backgroundColor = .gray
        textField.font = .systemFont(ofSize: 20)
        return textField
    }()
        // 습관 제목 아래 밑줄과 카운트 라벨
        lazy var lineView1: UIView = {
            let line = UIView()
            line.backgroundColor = .app_PrimaryColor
            return line
        }()
        
        lazy var textCount1: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .app_BrightnessColor40
            label.text = "0/20"
            return label
        }()
    
    /// 해쉬태그 텍스트 필드
    lazy var hashtagTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "# 해쉬태그를 입력해 보세요!"
        //textField.textAlignment = .center
        textField.textColor = .app_BrightnessColor100
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
        // 습관 제목 아래 밑줄과 카운트 라벨
        lazy var lineView2: UIView = {
            let line = UIView()
            line.backgroundColor = .app_PrimaryColor
            return line
        }()
        
        lazy var textCount2: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .app_BrightnessColor40
            label.text = "0/8"
            return label
        }()
    
    // 사진 첨부 버튼
    lazy var addImageButton: UIButton = {
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 10)
        
        var config = UIButton.Configuration.bordered()
        config.image = UIImage(systemName: "camera") // 이미지 설정
        config.baseForegroundColor = .app_BrightnessColor60
        config.preferredSymbolConfigurationForImage =  UIImage.SymbolConfiguration(pointSize: 18, weight: .medium) //아이콘 크기
        config.imagePadding = 5 //패딩값
        config.imagePlacement = .top //이미지 위치
        config.baseBackgroundColor = UIColor.white //버튼 배경색
        config.attributedTitle = AttributedString("사진을 첨부해 보세요!", attributes: titleContainer)
        
        let btn = UIButton(configuration: config)
        btn.setTitleColor(.app_BrightnessColor40, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.layer.borderColor = UIColor.app_BrightnessColor40.cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true // 사진 선택으로 배경사진이 바뀔 때 테두리에 잘리게
        btn.imageView?.contentMode = .scaleAspectFill // 배경 사진이 바뀔 때 비율 유지하게
        return btn
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
            titleTextField,
            lineView1,
            textCount1,
            hashtagTextField,
            lineView2,
            textCount2,
            addImageButton,
            contentTextView,
            textCount3,
            nextBtn
        ].forEach {self.addSubview($0)}
    }
    
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(30)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(40)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
            lineView1.snp.makeConstraints {
                $0.bottom.equalTo(titleTextField).offset(8)
                $0.horizontalEdges.equalTo(titleTextField)
                $0.height.equalTo(1)
            }
            
            textCount1.snp.makeConstraints {
                $0.trailing.equalTo(lineView1).offset(-5)
                $0.top.equalTo(lineView1.snp.bottom).offset(5)
            }
        
        hashtagTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(40)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
            lineView2.snp.makeConstraints {
                $0.bottom.equalTo(hashtagTextField).offset(8)
                $0.horizontalEdges.equalTo(hashtagTextField)
                $0.height.equalTo(1)
            }
            
            textCount2.snp.makeConstraints {
                $0.trailing.equalTo(lineView2).offset(-5)
                $0.top.equalTo(lineView2.snp.bottom).offset(5)
            }
        
        
        addImageButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(180)
            $0.top.equalTo(hashtagTextField.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.width.equalTo(addImageButton)
            $0.height.equalTo(150)
            $0.top.equalTo(addImageButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        textCount3.snp.makeConstraints {
            $0.trailing.equalTo(contentTextView).offset(-5)
            $0.top.equalTo(contentTextView.snp.bottom).offset(5)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide ).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
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

