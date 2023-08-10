//
//  HabitCreate_chooseType_View.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

/// 습관 개설 뷰 첫번째
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : HC_chooseTypeViewController
class HabitCreate_chooseTypeView: UIView {
    
    /// 커스텀 네비게이션바
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    /// 뷰 타이틀
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "어떤 방식으로\n함께 습관을 만들고 싶나요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    /// Private 들어가는 뷰
    lazy var view_private : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        // tag를 선택 지표로 활용합니다
        view.tag = 0
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.app_SecondaryColor2.cgColor
        
        //그림자
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    /// private 사람 아이콘 이미지
    lazy var imageView_private : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "singlePerson")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .app_SecondaryColor2
        return view
    }()
    
    /// "Private" 라벨
    lazy var titleLabel_private : UILabel = {
        let label = UILabel()
        label.text = "Private"
        label.textColor = .app_SecondaryColor2
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    /// Public 들어가는 뷰
    lazy var view_public : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.tag = 1 // tag를 선택 지표로 활용합니다
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.app_SecondaryColor2.cgColor
        
        //그림자
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    /// Public 사람 아이콘 이미지
    lazy var imageView_public : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "doublePerson")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .app_SecondaryColor2
        return view
    }()
    
    /// "Public" 라벨
    lazy var titleLabel_public : UILabel = {
        let label = UILabel()
        label.text = "Public"
        label.textColor = .app_SecondaryColor2
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    /// private 뷰 밑 설명 라벨
    lazy var contentLabel_private : UILabel = {
        let label = UILabel()
        let inputText = "친구들과\n습관 형성하기"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        
        let attributedText = NSMutableAttributedString(string: inputText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: 3))
        label.attributedText = attributedText
        
        return label
    }()
    
    /// public 뷰 밑 설명 라벨
    lazy var contentLabel_public : UILabel = {
        let label = UILabel()
        let inputText = "모르는 사람들과\n습관 형성하기"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        
        let attributedText = NSMutableAttributedString(string: inputText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: 3))
        label.attributedText = attributedText
        
        return label
    }()
    
    /// 다음 버튼
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()
    
    func addSubviews(){
        [
            imageView_private,
            titleLabel_private
        ].forEach {view_private.addSubview($0)}
        
        [
            imageView_public,
            titleLabel_public,
        ].forEach {view_public.addSubview($0)}
        
        [
            navigationBar,
            topLabel,
            view_private,
            view_public,
            contentLabel_private,
            contentLabel_public,
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
        
        
        view_private.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
        }
        
        imageView_private.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-15)
        }
        
        titleLabel_private.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        view_public.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        imageView_public.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(70)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-15)
        }
        
        titleLabel_public.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        contentLabel_private.snp.makeConstraints {
            $0.width.equalTo(view_private)
            $0.height.equalTo(100)
            $0.top.equalTo(view_private.snp.bottom).offset(10)
            $0.centerX.equalTo(view_private)
        }
        
        contentLabel_public.snp.makeConstraints {
            $0.width.equalTo(view_public)
            $0.height.equalTo(100)
            $0.top.equalTo(view_public.snp.bottom).offset(10)
            $0.centerX.equalTo(view_public)
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
struct HabitCreate_chooseType_View_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseTypeViewController()
            return ViewController
        }
    }
}
