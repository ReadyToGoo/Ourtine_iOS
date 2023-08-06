//
//  HC_memberCountView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/07.
//

import UIKit
import SnapKit

/// 습관 개설 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
class HabitCreate_memberCountView: UIView {
    
    /// 커스텀 네비게이션바
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "몇 명과 함께 할까요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    /// 타이틀 아래 서브타이틀 - 부제목
    lazy var secondLabel : UILabel = {
        let label = UILabel()
        label.text = "본인을 포함한 총 참여 인원 수를 설정해 주세요."
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    /// 서브타이틀 아래 서서브타이틀 - 부부제목
    lazy var thirdLabel : UILabel = {
        let label = UILabel()
        label.text = "*최대 6명"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    /// 명수 텍스트 필드
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .app_BrightnessColor100
        textField.font = .systemFont(ofSize: 25)
        return textField
    }()
    
    /// 텍스트필드 아랫줄
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .app_BrightnessColor100
        return line
    }()
    
    /// 텍스트 필드 옆 "명" 라벨
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "명"
        label.textColor = .black
        label.font = .systemFont(ofSize: 35, weight: .medium)
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
            secondLabel,
            thirdLabel,
            textField,
            countLabel,
            lineView,
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
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(20)
            $0.leading.equalTo(topLabel)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom)
            $0.leading.equalTo(topLabel)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(20)
            $0.leading.equalTo(topLabel)
            $0.height.equalTo(50)
            $0.width.equalTo(70)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalTo(textField)
            $0.horizontalEdges.equalTo(textField)
            $0.height.equalTo(1)
        }
        
        countLabel.snp.makeConstraints {
            $0.bottom.equalTo(textField)
            $0.leading.equalTo(textField.snp.trailing).offset(5)
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
struct HabitCreate_memberCountView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_memberCountViewController()
            return ViewController
        }
    }
}
