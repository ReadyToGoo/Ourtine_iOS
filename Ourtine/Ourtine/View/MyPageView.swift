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
        
        label.attributedText = attributedText
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
    
    // 중간 라인
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .app_BrightnessColor40
        return line
    }()
    
    // 중간 바 위클리 로그 라벨
    lazy var weeklyLogLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Weekly-Log")
        
        let bigFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: attributedText.length))
        
        label.attributedText = attributedText
        return label
    }()
    
    // 인증 현황, 위클리 로그 작성 라벨
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "인증 현황\n위클리로그 작성하기")
        
        let bigFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: 5))
        
        let smallFont = UIFont.systemFont(ofSize: 16, weight: .light)
        attributedText.addAttribute(.font, value: smallFont, range: NSRange(location: 5, length: 11  ))
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_BrightnessColor60, range: NSRange(location: 5, length: 11  ))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    // > 버튼 이미지
    lazy var btnImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .app_BrightnessColor60
        return view
    }()
    
    // 탭 제스처가 적용되는 뷰
    lazy var logTapView = UIView()
    
    // 요일별 습관 보이는 스택뷰
    lazy var logStackView: UIStackView = {
        let view = UIStackView()
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.clipsToBounds = true
        
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillProportionally
        
        view.backgroundColor = .app_SecondaryColor
        return view
    }()
    
        // 요일 스택 셀
        lazy var monCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "월"
            return cell
        }()
        
        // 요일 스택 셀
        lazy var tueCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "화"
            return cell
        }()
        
        // 요일 스택 셀
        lazy var wedCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "수"
            return cell
        }()
        
        // 요일 스택 셀
        lazy var thuCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "목"
            return cell
        }()
        
        // 요일 스택 셀
        lazy var friCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "금"
            return cell
        }()
        
        // 요일 스택 셀
        lazy var satCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "토"
            return cell
        }()
        
        // 요일 스택 셀
        lazy var sunCell: WeeklyStatusStackCell = {
            let cell = WeeklyStatusStackCell()
            cell.dayLabel.text = "일"
            return cell
        }()
    
    // 이번주 감정 라벨
    lazy var feelingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "이번주 감정")
        
        let bigFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        attributedText.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: 6))
        
        label.attributedText = attributedText
        return label
    }()
    
    // 이번주 감정 보이는 스택뷰
    lazy var feelingStackView: UIStackView = {
        let view = UIStackView()
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0
        
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillProportionally
        
        view.backgroundColor = .clear
        return view
    }()
    
        lazy var firstFeelingCell: WeeklyFeelingStackCell = {
            let cell = WeeklyFeelingStackCell()
            cell.getCellData(image: UIImage(named: "feeling1") ?? UIImage(), text: "매우 좋아요", count: 13)
            return cell
        }()
        
        lazy var secondFeelingCell: WeeklyFeelingStackCell = {
            let cell = WeeklyFeelingStackCell()
            cell.getCellData(image: UIImage(named: "feeling2") ?? UIImage(), text: "좋아요", count: 16)
            return cell
        }()
        
        lazy var thirdFeelingCell: WeeklyFeelingStackCell = {
            let cell = WeeklyFeelingStackCell()
            cell.getCellData(image: UIImage(named: "feeling3") ?? UIImage(), text: "괜찮아요", count: 4)
            return cell
        }()
        
        lazy var fourthFeelingCell: WeeklyFeelingStackCell = {
            let cell = WeeklyFeelingStackCell()
            cell.getCellData(image: UIImage(named: "feeling4") ?? UIImage(), text: "별로에요", count: 2)
            return cell
        }()
        
        lazy var fifthFeelingCell: WeeklyFeelingStackCell = {
            let cell = WeeklyFeelingStackCell()
            cell.getCellData(image: UIImage(named: "feeling5") ?? UIImage(), text: "매우 별로에요", count: 0)
            return cell
        }()
    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        
        [
            monCell,
            tueCell,
            wedCell,
            thuCell,
            friCell,
            satCell,
            sunCell
        ].forEach { logStackView.addArrangedSubview($0)}
        
        [
            firstFeelingCell,
            secondFeelingCell,
            thirdFeelingCell,
            fourthFeelingCell,
            fifthFeelingCell
        ].forEach { feelingStackView.addArrangedSubview($0)}
        
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
            habitCountLabel,
            lineView,
            weeklyLogLabel,
            statusLabel,
            btnImage,
            logTapView,
            logStackView,
            feelingLabel,
            feelingStackView
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
            $0.size.equalTo(120)
        }
        
        followingNum.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(35)
            $0.top.equalTo(profileImage).offset(10)
        }
        
        followingLabel.snp.makeConstraints {
            $0.centerX.equalTo(followingNum)
            $0.top.equalTo(followingNum.snp.bottom).offset(3)
        }
        
        followerNum.snp.makeConstraints {
            $0.leading.equalTo(followingNum.snp.trailing).offset(25)
            $0.top.equalTo(followingNum)
        }
        
        followerLabel.snp.makeConstraints {
            $0.centerX.equalTo(followerNum)
            $0.top.equalTo(followerNum.snp.bottom).offset(3)
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
            $0.top.equalTo(profileImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview().offset(-80)
        }
        
        labelCapsule2.snp.makeConstraints {
            $0.center.equalTo(habitLabel)
            $0.height.equalTo(habitLabel).multipliedBy(1.8)
            $0.width.equalTo(screenWidth/3)
        }
        
        habitLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(30)
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
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(habitCountLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        weeklyLogLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(weeklyLogLabel.snp.bottom).offset(20)
            $0.leading.equalTo(weeklyLogLabel).offset(10)
        }
        
        btnImage.snp.makeConstraints {
            $0.bottom.equalTo(statusLabel)
            $0.leading.equalTo(statusLabel.snp.trailing).offset(5)
        }
        
        logTapView.snp.makeConstraints {
            $0.top.leading.equalTo(statusLabel)
            $0.bottom.trailing.equalTo(btnImage)
        }
        
        logStackView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(logTapView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(-20)
        }
        
        feelingLabel.snp.makeConstraints {
            $0.top.equalTo(logStackView.snp.bottom).offset(20)
            $0.leading.equalTo(statusLabel)
        }
        
        feelingStackView.snp.makeConstraints {
            $0.top.equalTo(feelingLabel.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(140)
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
