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
    
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "어떤 방식으로\n함께 습관을 만들고 싶나요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    lazy var imageView_private : UIImageView = {
        let label = UILabel()
        label.text = "private"
        label.textColor = .black
        
        let view = UIImageView()
        view.backgroundColor = .gray
        view.tag = 10
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var imageView_public : UIImageView = {
        let label = UILabel()
        label.text = "public"
        label.textColor = .black
        
        let view = UIImageView()
        view.backgroundColor = .gray
        view.tag = 20
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var label_private : UILabel = {
        let label = UILabel()
        label.text = "나는 내 친구와 좀 더 편하게 습관을 형성하고 싶어요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var label_public : UILabel = {
        let label = UILabel()
        label.text = "나는 모르는 사람들과 서로 자극받으며 습관을 형성하고 싶어요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()
    
    lazy var highlightBox: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.blue.cgColor
        view.isHidden = true
        return view
    }()
    
    func addSubviews(){
        [
            navigationBar,
            topLabel,
            imageView_private,
            imageView_public,
            label_private,
            label_public,
            highlightBox,
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
        
        
        imageView_private.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalToSuperview().multipliedBy(0.35)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        imageView_public.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalToSuperview().multipliedBy(0.35)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        label_private.snp.makeConstraints {
            $0.width.equalTo(imageView_private)
            $0.height.equalTo(100)
            $0.top.equalTo(imageView_private.snp.bottom).offset(10)
            $0.centerX.equalTo(imageView_private)
        }
        
        label_public.snp.makeConstraints {
            $0.width.equalTo(imageView_public)
            $0.height.equalTo(100)
            $0.top.equalTo(imageView_public.snp.bottom).offset(10)
            $0.centerX.equalTo(imageView_public)
        }
        
        highlightBox.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(imageView_private)
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
struct HabitCreate_chooseType_View_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseTypeViewController()
            return ViewController
        }
    }
}
