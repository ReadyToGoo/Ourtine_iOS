//
//  HC_noFriendsView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit
import SnapKit

class HabitCreate_noFriednsView: UIView {
    
    // lazy = 이 친구가 호출될때 생성되는 애
    // 그냥 var로만 선언하게되면 앱을 처음 킬때 얘네를 다불러와요
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    /// "앗!"
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "앗!"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    /// "친구가 없네요!"
    lazy var secondLabel : UILabel = {
        let label = UILabel()
        label.text = "습관에 초대할 친구가 없네요!"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    /// 서브타이틀
    lazy var thirdLabel : UILabel = {
        let label = UILabel()
        label.text = "팔로잉할 친구가 없다면 Private형으로\n습관을 개설하기가 어려워요!"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    
    
    lazy var goPublicBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("그럼 Public형으로 개설할게요!", for: .normal)
        return btn
    }()
    
    lazy var laterBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("그럼 다음에 다시 만들게요!", for: .normal)
        return btn
    }()
    
    
    /// 뷰 요소 추가 함수
    func addSubviews(){
        [
            navigationBar,
            topLabel,
            secondLabel,
            thirdLabel,
            goPublicBtn,
            laterBtn
        ].forEach {self.addSubview($0)}
        
    }
    
    /// 뷰 요소들 위치 잡아준 함수
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(secondLabel.snp.top).offset(-40)
        }
        
        secondLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-90)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        goPublicBtn.snp.makeConstraints {
            $0.bottom.equalTo(laterBtn.snp.top).offset(-10)
            $0.size.equalTo(laterBtn)
            $0.centerX.equalToSuperview()
        }
        
        laterBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide ).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    // 뷰컨틀롤러의 viewDidLoad()
    //처음에 이 뷰가 호출되었을때, 보여지기 전에 한번 쭉 실행되는 함수 (초기화)
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
struct HabitCreate_noFriednsView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_noFriednsViewController()
            return ViewController
        }
    }
}
