//
//  MyPageView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/11.
//

import UIKit
import SnapKit

/// 검색 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : SearchViewController
class MyPageView: UIView {
    
    // 상단 커스텀 네비게이션바 (예비용)
    //lazy var navigationBar = Custom_NavigationBar()
    lazy var navigationBar: Custom_NavigationBar = {
        let navBar = Custom_NavigationBar()
        navBar.setItems([], animated: false)
        return navBar
    }()
    
    // 상단 바 닉네임 라벨
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Minseo_00 님")
        
        let bigFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length - 2))
        
        let smallFont = UIFont.systemFont(ofSize: 18, weight: .light)
        attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: attributedText.length - 2, length: 2))
        
//        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: attributedText.length - 1, length: 1))
        label.attributedText = attributedText
        //label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    // 상단바 설정 버튼
    lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "gearshape"), for: .normal)
        btn.tintColor = .app_BrightnessColor40
        return btn
    }()
    
    // 프로필 이미지
    lazy var profileImage: UserProfileImageView = {
        let imgView = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return imgView
    }()
    
    // 팔로잉 수
    lazy var followingNum: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "120"
        label.textColor = .black
        return label
    }()
    
    // 팔로잉 라벨
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "팔로잉"
        label.textColor = .black
        return label
    }()
    
    // 팔로워 수
    lazy var followerNum: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "180"
        label.textColor = .black
        return label
    }()
    
    // 팔로워 라벨
    lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "팔로워"
        label.textColor = .black
        return label
    }()
    
    // 다짐 라벨
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "하루의 시작을 활기차게 해보고자 아워틴을 깔게 되었습니다!"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    // 라벨 캡슐
    lazy var labelCapsule1: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 20
        return view
    }()
    
    // "참여율" 라벨
    lazy var participateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "참여율"
        label.textColor = .black
        return label
    }()
    
    // 참여율 수치 라벨
    lazy var participateRateLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "98 %")
        
        let bigFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length - 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: attributedText.length - 1))
        
        let smallFont = UIFont.systemFont(ofSize: 25, weight: .medium)
        attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: attributedText.length - 1, length: 1  ))
        
        
        label.attributedText = attributedText
        //label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    
    
    // 라벨 캡슐
    lazy var labelCapsule2: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 20
        return view
    }()
    
    // 참여한 습관 라벨
    lazy var habitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "참여한 습관"
        label.textColor = .black
        return label
    }()
    
    // 습관 개수 라벨
    lazy var habitCountLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "12 개")
        
        let bigFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length - 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: attributedText.length - 1))
        
        let smallFont = UIFont.systemFont(ofSize: 25, weight: .medium)
        attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: attributedText.length - 1, length: 1  ))
        
        
        label.attributedText = attributedText
        //label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        [
            navigationBar,
            nameLabel,
            settingBtn,
            profileImage,
            followingNum,
            followerNum,
            followingLabel,
            followerLabel,
            contentLabel,
            participateLabel,
            habitLabel,
            labelCapsule1,
            labelCapsule2,
            participateRateLabel,
            habitCountLabel
        ].forEach {self.addSubview($0)}
    }
        
    // 컴포넌트들 Constraints 설정
    func setConstraint() {
        
        //MARK: - NavigationBar
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(navigationBar)
            $0.leading.equalToSuperview().offset(20)
        }
        
        settingBtn.snp.makeConstraints {
            $0.centerY.equalTo(navigationBar)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(navigationBar.snp.bottom).offset(10)
            $0.size.equalTo(100)
        }
        
        followingNum.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(50)
            $0.top.equalTo(profileImage).offset(10)
        }
        
        followingLabel.snp.makeConstraints {
            $0.centerX.equalTo(followingNum)
            $0.top.equalTo(followingNum.snp.bottom).offset(10)
        }
        
        followerNum.snp.makeConstraints {
            $0.leading.equalTo(followingNum.snp.trailing).offset(25)
            $0.top.equalTo(followingNum)
        }
        
        followerLabel.snp.makeConstraints {
            $0.centerX.equalTo(followerNum)
            $0.top.equalTo(followerNum.snp.bottom).offset(10)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(followingNum).offset(-5)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(followingLabel.snp.bottom).offset(10)
        }
        
        labelCapsule1.snp.makeConstraints {
            $0.center.equalTo(participateLabel)
            $0.height.equalTo(participateLabel).multipliedBy(1.8)
            $0.width.equalTo(screenWidth/3)
        }
        
        participateLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview().offset(-80)
        }
        
        labelCapsule2.snp.makeConstraints {
            $0.center.equalTo(habitLabel)
            $0.height.equalTo(habitLabel).multipliedBy(1.8)
            $0.width.equalTo(screenWidth/3)
        }
        
        habitLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview().offset(80)
        }
        
        participateRateLabel.snp.makeConstraints {
            $0.top.equalTo(labelCapsule1.snp.bottom).offset(10)
            $0.centerX.equalTo(labelCapsule1)
        }
        
        habitCountLabel.snp.makeConstraints {
            $0.top.equalTo(labelCapsule2.snp.bottom).offset(10)
            $0.centerX.equalTo(labelCapsule2)
        }
        
    
    }
    
    // View를 처음 가져올 때 초기화 코드
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputSubview()
        setConstraint()
        self.backgroundColor = .white // 안해주면 배경이 투명색!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// Preview 코드 -> ViewController
import SwiftUI
struct MyPageView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = MyPageViewController()
            return ViewController
        }
    }
}
